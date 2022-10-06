import 'dart:io';
import 'dart:convert';

import 'package:agent_dart/utils/number.dart';
import 'package:app/eip4337lib/utils/log_utils.dart';
import 'package:app/web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:app/eip4337lib/entity/user_operation.dart';

const bundlerUrl = 'https://bundler-poc.soulwallets.me/';

class Send {
  static final httpClient = http.Client();
  static Future<dynamic> sendOp(UserOperation op) async {
    Log.d('${op.toString()}');
    final response =  await httpClient.post(Uri.parse(bundlerUrl), body: json.decode(op.toString()) as Map,
    headers: {'Content-Type': 'application/json'});
    return json.decode(response.body);
  }

  static Future<http.Response> getOpStateByReqeustId(String requestId) async {
    return await httpClient.get(Uri.parse(bundlerUrl + requestId));
  }

  static Future<dynamic> getOpStateByUserOperation(UserOperation op,
      EthereumAddress entryPointAddress, BigInt chainId) async {
    final requestId = bytesToHex(op.requestId(entryPointAddress, chainId));
    final response = await getOpStateByReqeustId(requestId);
    return json.decode(response.body);
  }

  static void sendOpWait(Web3Client web3, UserOperation op, EthereumAddress entryPointAddress, BigInt chainId) async {
    Log.d('sendOpWait');
    final res0 = await sendOp(op);
    Log.d('sendOp');
    if (res0['code'] == 0) {
      for (var i = 0; i < 60; i++) {
        sleep(Duration(seconds: 1));
        final res = await getOpStateByUserOperation(op, entryPointAddress, chainId);
        if (res['code'] == 0) {
          print('pending...');
        } else if (res['code'] == 1) {
          print('replaced with request id ${res["requestId"]}');
          break;
        } else if (res['code'] == 2) {
          print('processing...');
        } else if (res['code'] == 3) {
          for (var i = 0; i < 60; i++) {
            sleep(Duration(seconds: 1));
            final receipt = await web3.getTransactionReceipt(res["txHash"]);
            if (receipt!.status == true) {
              print('tx: ${res["txHash"]} has been confirmed');
            } else {
              throw(Exception('transaction failed'));
            }
          }
        } else if (res['code'] == 4) {
          print('failed $res');
        } else if (res['code'] == 5) {
          print('notfound');
        }
      }
    } else {
      print(res0);
      throw(Exception('activateOp failed'));
    }
  }

}