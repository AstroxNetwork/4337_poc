

import 'dart:convert';

import 'package:app/eip4337lib/backend/request.dart';
import 'package:app/eip4337lib/context/context.dart';
import 'package:app/eip4337lib/utils/helper.dart';
import 'package:web3dart/web3dart.dart';

void main() async {
  Map params = {'email': 'sky@ccc.com'};
  // final response = await Request.verifyEmail(params);
  final response = await Request.getWalletAddress(params);
  // params['code'] = '888888';
  // final response = await Request.addAccount(params);
  // params['wallet_address'] = '0x8af8c26D62954B5CA17B7EEA5231b0F9893aDD9f';
  // params['key'] = '0x8af8c26D62954B5CA17B7EEA5231b0F9893aDD9f';
  // final response = await Request.updateAccount(params);

  // {"code":400,"msg":"Code is not valid.","data":{}}
  // {"code":200,"msg":"Add record successfully.","data":{"jwtToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNreWhpZ2hmZW5nQGdtYWlsLmNvbSIsImlhdCI6MTY2NDQ1ODgzOSwiZXhwIjoxNjY1NzU0ODM5fQ.QssiBtGElqIwuzSIaZJyRW8Jyw_iNQmDFQaEOdm2Bmg"}}
  print(response.data);
  final body = response.data!;
  print(body['data']['wallet_address']);

  // final web3 = Web3Helper.web3();
  // WalletContext.createAccount(web3);
  // final ctx = WalletContext.getInstance();
  // ctx.setWalletAddress('0x62d00c12903832be82Fb6140A35E102Cab2dE7dD');
  // // final balance = await ctx.getEthBalance();
  // final balance = await ctx.getWEthBalance();
  // print(balance);
}