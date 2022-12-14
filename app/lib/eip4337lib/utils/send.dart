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
    final body = jsonEncode(op.toJson());
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

  static Future<String> sendOpWait(
    Web3Client web3,
    UserOperation op,
    EthereumAddress entryPointAddress,
    BigInt chainId,
  ) async {
    const String tag = 'sendOpWait';
    final res0 = await sendOp(op);
    LogUtil.d('[sendOpWait] $res0', tag: tag);
    if (res0['code'] != 0) {
      LogUtil.e('[sendOpWait] return $res0', tag: tag);
      throw Exception('[sendOpWait] failed ($res0)');
    }
    final requestId = res0['requestId'];
    for (int i = 0; i < 30; i++) {
      await Future.delayed(const Duration(seconds: 1));
      final response = await getOpStateByRequestId(requestId);
      final res = response.data;
      if (res['code'] == 1) {
        LogUtil.d('replaced with request id ${res["requestId"]}', tag: tag);
        throw Exception('Another OP participating.');
      }
      if (res['code'] == 0) {
        LogUtil.d('[sendOpWait ($i)] pending...', tag: tag);
      } else if (res['code'] == 2) {
        LogUtil.d('[sendOpWait ($i)] processing...', tag: tag);
      } else if (res['code'] == 3) {
        final hash = res["txHash"];
        for (int j = 0; j < 30; j++) {
          await Future.delayed(const Duration(seconds: 1));
          final receipt = await web3.getTransactionReceipt(hash);
          if (receipt?.status == true) {
            LogUtil.d(
              '[sendOpWait ($i:$j)] TX ($hash) has been confirmed',
              tag: tag,
            );
            return hash;
          } else {
            LogUtil.d('[sendOpWait ($i:$j)] TX receipt: $receipt', tag: tag);
          }
        }
        break;
      } else if (res['code'] == 4) {
        LogUtil.e('[sendOpWait ($i)] failed ($res)', tag: tag);
        break;
      } else if (res['code'] == 5) {
        LogUtil.e('[sendOpWait ($i)] not found ($res)', tag: tag);
        break;
      }
    }
    throw Exception('[sendOpWait] $requestId failed: ($res0)');
  }
}
