import 'dart:convert';

import 'package:agent_dart/utils/number.dart';
import 'package:app/eip4337lib/entity/user_operation.dart';
import 'package:app/web3dart/web3dart.dart';
import 'package:dio/dio.dart';

import 'log_util.dart';

const bundlerUrl = 'https://bundler-poc.soulwallets.me/';

class Send {
  static final _dio = Dio(
    BaseOptions(contentType: 'application/json;charset=utf-8'),
  );

  static Future<Map<String, dynamic>> sendOp(UserOperation op) async {
    final body = jsonEncode(op.toMap());
    final response = await _dio.put(bundlerUrl, data: body);
    return response.data;
  }

  static Future<Response> getOpStateByRequestId(String requestId) {
    return _dio.get(bundlerUrl + requestId);
  }

  static Future getOpStateByUserOperation(
    UserOperation op,
    EthereumAddress entryPointAddress,
    BigInt chainId,
  ) async {
    final requestId = bytesToHex(
      op.requestId(entryPointAddress, chainId),
      include0x: true,
    );
    final response = await getOpStateByRequestId(requestId);
    return response.data;
  }

  static Future<dynamic> sendOpWait(
    Web3Client web3,
    UserOperation op,
    EthereumAddress entryPointAddress,
    BigInt chainId,
  ) async {
    final res0 = await sendOp(op);
    if (res0['code'] == 0) {
      final requestId = res0['requestId'];
      for (var i = 0; i < 60; i++) {
        await Future.delayed(const Duration(seconds: 1));
        // final res = await getOpStateByUserOperation(op, entryPointAddress, chainId);
        final response = await getOpStateByRequestId(requestId);
        final res = response.data;
        if (res['code'] == 0) {
          LogUtil.d('pending...');
        } else if (res['code'] == 1) {
          LogUtil.d('replaced with request id ${res["requestId"]}');
          break;
        } else if (res['code'] == 2) {
          LogUtil.d('processing...');
        } else if (res['code'] == 3) {
          final hash = res["txHash"];
          for (var i = 0; i < 60; i++) {
            await Future.delayed(const Duration(seconds: 1));
            final receipt = await web3.getTransactionReceipt(hash);
            if (receipt?.status == true) {
              LogUtil.d('tx: $hash has been confirmed');
              return hash;
            } else {
              LogUtil.d('tx receipt: $receipt');
              // throw(Exception('transaction failed'));
            }
          }
        } else if (res['code'] == 4) {
          LogUtil.d('failed $res');
          break;
        } else if (res['code'] == 5) {
          LogUtil.d('notfound');
          break;
        }
      }
    } else {
      LogUtil.e('sendOp return $res0');
      throw Exception('activateOp failed');
    }
  }
}
