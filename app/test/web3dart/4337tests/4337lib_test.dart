import 'package:app/eip4337lib/context/context.dart';
import 'package:app/eip4337lib/define/address.dart';
import 'package:app/eip4337lib/utils/guardian.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:app/eip4337lib/utils/send.dart';
import 'package:app/eip4337lib/utils/user_op.dart';
import 'package:app/web3dart/contracts.dart';
import 'package:app/web3dart/crypto.dart';
import 'package:app/web3dart/web3dart.dart';

import 'package:app/eip4337lib/EIP4337Lib.dart';
import 'package:app/eip4337lib/contracts/entryPoint.dart';
import 'package:app/eip4337lib/utils/helper.dart';

const SPONSER_KEY =
    "0xa6df89ed3e4f20e095f08730dd5435875ee6fa6e2b33bca5fb59f62afc06a56b";
// const USER_PRIVATE_KEY =
//     "0x0061673ca1536d71ea0f0b31640be07ce92613df645e05fff338edb560381da5";
// const USER_PRIVATE_KEY =
//     "0x13333840f99337428ffa54331d4854481ba8ea8fc1335f8775292b8958963763";
const USER_PRIVATE_KEY =
    "0x214306b6552884da884b199938a86225a0221d5e775bd65dd528e229735ddf72";
const PAYMASTER_PRIVATE_KEY =
    "0xa6df89ed3e4f20e095f08730dd5435875ee6fa6e2b33bca5fb59f62afc06a56b";
const PAYMASTER_SIGN_KEY =
    "0xd076a42bda94685d1c26d43362884b40cdcfd38e3e2e0b445f97fc37c35362d5";
const BENEFICIARY_ADDR = "0x64dBEb9F393D40b3B33d192cB94F59090aBB5d77";

const entrypoint = '0x516638fcc2De106C325369187b86747fB29EbF32';
final entryPointAddress = EthereumAddress.fromHex(entrypoint);
const wethContract = '0x2787015262404f11d7B6920C7eB46e25595e2Bf5';
final wethContractAddress = EthereumAddress.fromHex(wethContract);
const wethPaymaster = '0x6cfE69b93B91dBfF4d2ea04fFd35dcc06490be4D';
final wethPaymasterAddress = EthereumAddress.fromHex(wethPaymaster);
const zeroAccount = '0x0000000000000000000000000000000000000000';
final zeroAddress = EthereumAddress.fromHex(zeroAccount);

const apiUrl = "https://ropsten.infura.io/v3/754cdf1de04349e1b5687b8a592cb536";
const _tag = '4337lib_test';

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
  LogUtil.isNativeLogging = true;
  // var httpClient = Client();
  // var ethClient = Web3Client(apiUrl, httpClient);
  final ethClient = Web3Helper.client;
  final chainId = await ethClient.getChainId();
  LogUtil.d(chainId, tag: _tag);

  final sponser = Web3Helper.recoverKeys(SPONSER_KEY);
  final address = await sponser.extractAddress();
  final balance = await ethClient.getBalance(address);
  LogUtil.d('$address : ${balance.getValueInUnit(EtherUnit.ether)}', tag: _tag);

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
    wethPaymasterAddress,
    simpleWalletCreateSalt,
  );
  LogUtil.d('simpleWalletAddress: $simpleWallet', tag: _tag);
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
  var activateOp = EIP4337Lib.activateWalletOp(
    Goerli.entryPointAddress,
    Goerli.paymasterAddress,
    userAddress,
    Goerli.wethAddress,
    gasMax,
    gasPriority,
    BigInt.zero,
  );
  // print(op);

  final requestId = activateOp.requestId(
    Goerli.entryPointAddress,
    Goerli.chainId,
  );
  LogUtil.d(
    'requestId: ${bytesToHex(requestId, include0x: true)}, user: $userAddress',
    tag: _tag,
  );
  final signature = await user.signPersonalMessage(requestId);
  // print('signature ${bytesToHex(signature)}');
  activateOp.signWithSignature(user.address, signature);
  // print(activateOp);

  /// ########### simulate
  final code = await ethClient.getCode(simpleWalletAddress);
  LogUtil.d('send op ${code.isEmpty}', tag: _tag);
  if (code.isEmpty) {
    final entryPointContract = DeployedContract(
      EntryPoint().ABI,
      entryPointAddress,
    );
    final simulateValidation = entryPointContract.function(
      "simulateValidation",
    );

    try {
      final response = await ethClient.call(
        sender: zeroAddress,
        contract: entryPointContract,
        function: simulateValidation,
        params: [activateOp.toTuple()],
      );
      LogUtil.d('ethClient.call $response', tag: _tag);
      final txHash = await Send.sendOpWait(
        ethClient,
        activateOp,
        entryPointAddress,
        chainId,
      );
      LogUtil.d('txHash $txHash', tag: _tag);
    } catch (e, s) {
      LogUtil.e('catch $e', stackTrace: s, tag: _tag);
    }
  } else {
    LogUtil.d("simpleWalletAddress $simpleWalletAddress inited", tag: _tag);

    // add account and wallet
    WalletContext.recoverPrivateKey(ethClient, USER_PRIVATE_KEY);
    final ctx = WalletContext.getInstance();
    ctx.setWalletAddress(simpleWallet);
    final toAddress = EthereumAddress.fromHex(
      '0x8af8c26D62954B5CA17B7EEA5231b0F9893aDD9f',
    );
    final amount = EtherAmount.fromUnitAndValue(EtherUnit.finney, 1).getInWei;

    // LogUtil.d("sendERC20 $toAddress, $amount", tag: _tag);
    // await ctx.sendERC20(wethContractAddress, toAddress, amount);
    // await ctx.sendETH(toAddress, amount);
  }

  /// ########### guardian
  final guardian1 = Web3Helper.recoverKeys(
    "0x42a1294da28d5cbac9be9e3e11ffcf854ec734799dc4f7cdf34a7edafaca8a80",
  );
  final guardian1Address = guardian1.address;
  final guardian2 = Web3Helper.recoverKeys(
    "0x233bfc84b62f7abe72ba68f83849204c146a90fa675855644d6d5b9639e9f270",
  );
  final guardian2Address = guardian2.address;
  final guardian3 = Web3Helper.recoverKeys(
    "0x2ff7b5feddca0d5dfe64e75ee9ceb666daf2d94cbada23c78be1bec857d0b376",
  );
  final guardian3Address = guardian3.address;
  print('guardian1 $guardian1Address}');
  print('guardian2 $guardian2Address}');
  print('guardian3 $guardian3Address}');

  /// ########### addgruadian
  // if (code.isNotEmpty) {
  //   // add account and wallet
  //   WalletContext.recoverPrivateKey(ethClient, USER_PRIVATE_KEY);
  //   final ctx = WalletContext.getInstance();
  //   ctx.setWalletAddress(simpleWallet);
  //
  //   LogUtil.d("addGuardian $guardian1Address");
  //   await ctx.addGuardian(guardian1Address);
  // }

  final newOwner =  Web3Helper.recoverKeys(
    "0x2a6313b0912b6e723a63a3be68a7d62128b05e0bdd613237889ece19d4ac220a",
  );
  print('newOwner ${newOwner.address}');

  final nonce = await EIP4337Lib.getNonce(simpleWalletAddress, ethClient);
  print(nonce);

  final recoverOp = await Guardian.walletContract(ethClient, simpleWalletAddress)
      .transferOwner(nonce, newOwner.address, entryPointAddress, Goerli.paymasterAddress,
      BigInt.from(3000000000), BigInt.from(2000000000));
  print(recoverOp);

  final recoverId = recoverOp.requestId(Goerli.entryPointAddress, Goerli.chainId);
  print(bytesToHex(recoverId, include0x: true));

  final sign1 = await guardian1.signPersonalMessage(recoverId);
  final sign2 = await guardian2.signPersonalMessage(recoverId);
  print('guardian1 ${guardian1.address} sign1 ${bytesToHex(sign1, include0x: true)}');
  print('guardian2 ${guardian2.address} sign2 ${bytesToHex(sign2, include0x: true)}');

  final signerSigs = [
    [guardian2.address, sign2],
    [guardian1.address, sign1]
  ];

  final signPack = await packGuardiansSignByRequestId(requestId, signerSigs);
  print(bytesToHex(signPack));

}
