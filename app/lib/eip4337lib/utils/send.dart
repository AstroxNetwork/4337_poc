import 'dart:io';
import 'dart:convert';

import 'package:agent_dart/utils/number.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:app/web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:app/eip4337lib/entity/user_operation.dart';

const bundlerUrl = 'https://bundler-poc.soulwallets.me/';

class Send {
  static final httpClient = http.Client();
  static Future<dynamic> sendOp(UserOperation op) async {
    final body = jsonEncode(op.toMap());
    // print('sendOp $body, ${body.length}');
    final response =  await httpClient.put(Uri.parse(bundlerUrl), body: body,
    headers: {'Content-Type': 'application/json', 'accept': 'application/json' });
    return json.decode(response.body);
  }

  static Future<http.Response> getOpStateByReqeustId(String requestId) async {
    final url = bundlerUrl + requestId;
    // print('getOpStateByReqeustId: $url');
    return await httpClient.get(Uri.parse(bundlerUrl + requestId));
  }

  static Future getOpStateByUserOperation(UserOperation op,
      EthereumAddress entryPointAddress, BigInt chainId) async {
    final requestId = bytesToHex(op.requestId(entryPointAddress, chainId), include0x: true);
    final response = await getOpStateByReqeustId(requestId);
    print('getOpStateByUserOperation: $response');
    return json.decode(response.body);
  }

  static Future<dynamic> sendOpWait(Web3Client web3, UserOperation op, EthereumAddress entryPointAddress, BigInt chainId) async {
    print('sendOpWait');
    final res0 = await sendOp(op);
    print('sendOp $res0');
    if (res0['code'] == 0) {
      final requestId = res0['requestId'];
      for (var i = 0; i < 60; i++) {
        sleep(Duration(seconds: 1));
        // final res = await getOpStateByUserOperation(op, entryPointAddress, chainId);
        final response = await getOpStateByReqeustId(requestId);
        final res = json.decode(response.body);
        if (res['code'] == 0) {
          print('pending...');
        } else if (res['code'] == 1) {
          print('replaced with request id ${res["requestId"]}');
          break;
        } else if (res['code'] == 2) {
          print('processing...');
        } else if (res['code'] == 3) {
          final hash = res["txHash"];
          for (var i = 0; i < 60; i++) {
            sleep(Duration(seconds: 1));
            final receipt = await web3.getTransactionReceipt(hash);
            if (receipt?.status == true) {
              print('tx: ${hash} has been confirmed');
              return hash;
            } else {
              print('tx receipt: ${receipt}');
              // throw(Exception('transaction failed'));
            }
          }
        } else if (res['code'] == 4) {
          print('failed $res');
          break;
        } else if (res['code'] == 5) {
          print('notfound');
          break;
        }
      }
    } else {
      print('sendOp return $res0');
      throw(Exception('activateOp failed'));
    }
  }

}