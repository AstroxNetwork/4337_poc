

import 'package:app/eip4337lib/backend/request.dart';
import 'package:app/eip4337lib/context/context.dart';
import 'package:app/eip4337lib/utils/helper.dart';
import 'package:web3dart/web3dart.dart';

void main() async {
  // var params = Map();
  // params['email'] = 'skyhighfeng@gmail.com';
  // final response = await Request.verifyEmail(params);
  // // params['code'] = '198GFG';
  // // final response = await Request.addAccount(params);
  // // {"code":400,"msg":"Code is not valid.","data":{}}
  // // {"code":200,"msg":"Add record successfully.","data":{"jwtToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNreWhpZ2hmZW5nQGdtYWlsLmNvbSIsImlhdCI6MTY2NDQ1ODgzOSwiZXhwIjoxNjY1NzU0ODM5fQ.QssiBtGElqIwuzSIaZJyRW8Jyw_iNQmDFQaEOdm2Bmg"}}
  // print(response.body);

  final web3 = Web3Helper.web3();
  WalletContext.createAccount(web3);
  final ctx = WalletContext.getInstance();
  ctx.setWalletAddress('0x62d00c12903832be82Fb6140A35E102Cab2dE7dD');
  // final balance = await ctx.getEthBalance();
  final balance = await ctx.getWEthBalance();
  print(balance);
}