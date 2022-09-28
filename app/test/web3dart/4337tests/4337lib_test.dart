import 'package:app/web3dart/crypto.dart';
import 'package:http/http.dart';
import 'package:app/web3dart/web3dart.dart';
import 'package:app/web3dart/contracts.dart';

import 'package:app/eip4337lib/EIP4337Lib.dart';
import 'package:app/eip4337lib/contracts/entryPoint.dart';
import 'package:app/eip4337lib/contracts/weth.dart';
import 'package:app/eip4337lib/utils/helper.dart';

import 'abi.dart';

const SPONSER_KEY = "0xa6df89ed3e4f20e095f08730dd5435875ee6fa6e2b33bca5fb59f62afc06a56b";
const USER_PRIVATE_KEY = "0x214306b6552884da884b199938a86225a0221d5e775bd65dd528e229735ddf72";
const PAYMASTER_PRIVATE_KEY = "0xa6df89ed3e4f20e095f08730dd5435875ee6fa6e2b33bca5fb59f62afc06a56b";
const PAYMASTER_SIGN_KEY = "0xd076a42bda94685d1c26d43362884b40cdcfd38e3e2e0b445f97fc37c35362d5";
const BENEFICIARY_ADDR = "0x64dBEb9F393D40b3B33d192cB94F59090aBB5d77";

const entrypoint = '0xbAecF6408a14C2bbBF62c87C554689E0FFC24C34';
final entryPointAddress = EthereumAddress.fromHex(entrypoint);
const wethContract = '0xec2a384Fa762C96140c817079768a1cfd0e908EA';
final wethContractAddress = EthereumAddress.fromHex(wethContract);
const wethPaymaster = '0xc299849c75a38fC9c91A7254d0F51A1a385EEb7a';
final wethPaymasterAddress = EthereumAddress.fromHex(wethPaymaster);
const zeroAccount = '0x0000000000000000000000000000000000000000';
final zeroAddress = EthereumAddress.fromHex(zeroAccount);

final apiUrl = "https://ropsten.infura.io/v3/754cdf1de04349e1b5687b8a592cb536";


class Deposits {
  Deposits(List<dynamic> response)
      : amount = (response[0] as BigInt),
        unstakeDelaySec = (response[1] as BigInt),
        withdrawTime = (response[2] as BigInt);

  final BigInt amount;

  final BigInt unstakeDelaySec;

  final BigInt withdrawTime;
}


void main() async {
  // var httpClient = Client();
  // var ethClient = Web3Client(apiUrl, httpClient);
  final ethClient = Web3Helper.web3();
  final chainId = await ethClient.getChainId();
  // print(chainId);

  final sponser = Web3Helper.recoverKeys(SPONSER_KEY);
  final address = await sponser.extractAddress();
  final balance = await ethClient.getBalance(address);
  print('$address : ${balance.getValueInUnit(EtherUnit.ether)}');

  /// ########### getDepositInfo
  // final entryPointContract = DeployedContract(EntryPoint().ABI, entryPointAddress);
  // final getDepositInfo = entryPointContract.function("getDepositInfo");
  // final response = await ethClient.call(contract: entryPointContract, function: getDepositInfo, params: [
  //   wethPaymasterAddress
  // ]);
  // final depositInfo = Deposits(response[0]);
  // print('getDepositInfo: ${depositInfo.amount} ${depositInfo.unstakeDelaySec} ${depositInfo.withdrawTime}');

  /// ########### calculateWalletAddress
  final user = Web3Helper.recoverKeys(USER_PRIVATE_KEY);
  final userAddress = await user.extractAddress();
  final simpleWalletCreateSalt = BigInt.zero;
  // print('calculateWalletAddress: ${entryPointAddress.hex}, ${userAddress.hex}, ${wethContractAddress.hex}, ${wethPaymasterAddress.hex}' );
  final simpleWallet = EIP4337Lib.calculateWalletAddress(
      entryPointAddress,
      userAddress,
      wethContractAddress,
      wethPaymasterAddress, simpleWalletCreateSalt);
  print('simpleWalletAddress: $simpleWallet');
  final simpleWalletAddress = EthereumAddress.fromHex(simpleWallet);

  /// ########### weth balance
  // final wethContract = DeployedContract(WETH().ABI, wethContractAddress);
  // final balanceOf = wethContract.function("balanceOf");
  // final response = await ethClient.call(contract: wethContract, function: balanceOf, params: [
  //   simpleWalletAddress
  // ]);
  // print(response);
  // signAndSendTransaction

  /// ########### op
  // getGasPrice
  final gasMax = BigInt.from(3000000000);
  final gasPriority = BigInt.from(2000000000);
  var activateOp = EIP4337Lib.activateWalletOp(entryPointAddress, wethPaymasterAddress, userAddress, wethContractAddress,
      gasMax, gasPriority, simpleWalletCreateSalt);
  // print(op);

  final requestId = activateOp.requestId(entryPointAddress, chainId);
  // print('requestId: ${bytesToHex(requestId)}, user: $userAddress');
  final signature = await user.signPersonalMessage(requestId);
  // print('signature ${bytesToHex(signature)}');
  activateOp.signWithSignature(user.address, signature);
  // print(activateOp);

  /// ########### simulate
  final entryPointContract = DeployedContract(EntryPoint().ABI, entryPointAddress);
  final simulateValidation = entryPointContract.function("simulateValidation");

  final response = await ethClient.call(sender: zeroAddress, contract: entryPointContract, function: simulateValidation, params: [
    activateOp
  ]);
  print(response);


  // print(requestId);
}