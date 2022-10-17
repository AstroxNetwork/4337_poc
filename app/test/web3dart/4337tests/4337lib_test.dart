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

  // 0x4A4486568E3Ebb009c8fb9598A41D0718b517936
  // {
  //   sender: "0xbeB92Eee552C9E77e39F16fe9b1664CCdbf77d75",
  // nonce: 3,
  // initCode: "0x",
  // callData:
  // "0x4fb2e45d0000000000000000000000004a4486568e3ebb009c8fb9598a41d0718b517936",
  // callGas: 94979,
  // verificationGas: 153600,
  // preVerificationGas: 21000,
  // maxFeePerGas: 15000000000,
  // maxPriorityFeePerGas: 10000000000,
  // paymaster: "0x6cfE69b93B91dBfF4d2ea04fFd35dcc06490be4D",
  // paymasterData: "0x",
  // signature:
  // "0x0000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000010000000000000000000000000044aa7e13893c929cbcf8f1966db7aa47ea80924a00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000041a64c4813c209cad949368219b45fce676d65561e72e4c4834ce6b59a3fc9b25a4a911e3368eb190a315df0d543b2ed264a94a360417832dd3ac74e15d5442b221b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000bc4b82a8cd2a803bfb8e457d8d681b78d3f8495700000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000041c5b87f56a12db7354d56d6bf8abc9f0f839bc95823b352a534550b2c10b6a0da50d78ab5ff9980aac6a6213c527173ed20834d500946ed0198d5f598bb9731a31c00000000000000000000000000000000000000000000000000000000000000",
  // }

  //     {
  //   "sender": "0x26aefa70921946c9353ff80737fbcbe97e17df74",
  // "nonce": "2",
  // "callGas": "94979",
  // "initCode": "0x",
  // "callData": "0x4fb2e45d000000000000000000000000c324629acd5938bf4201cf3062dd696aeb2b071b",
  // "verificationGas": "153600",
  // "preVerificationGas": "21000",
  // "maxFeePerGas": "15000000000",
  // "maxPriorityFeePerGas": "10000000000",
  // "paymaster": "0x6cfe69b93b91dbff4d2ea04ffd35dcc06490be4d",
  // "paymasterData": "0x",
  // "signature": "0x0000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000010000000000000000000000000044aa7e13893c929cbcf8f1966db7aa47ea80924a00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000041c3597245657ee3d7ad4440b76f59b8bde36fce29896c3b08549e7ba4e98257741169cd7d8ec206081b3187425760c95f49f4c4ae44b5a8a047d25ff45271d3491b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000bc4b82a8cd2a803bfb8e457d8d681b78d3f84957000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000410ca30c68bb2b21bb5cb9577dfd532fedd12d142bb714f52f7842de6ab6c74cea0d735a4963fc70fe4ba6d9d7e3c27ece875b2a7230b3752652aa3ad9797958291b00000000000000000000000000000000000000000000000000000000000000"
  // }

  // 0x26aefa70921946c9353ff80737fbcbe97e17df74
  // 0xc324629acd5938bf4201cf3062dd696aeb2b071b
  //
  // 0xbc4b82A8cd2a803bFB8e457d8D681b78D3F84957
  // 0x0ca30c68bb2b21bb5cb9577dfd532fedd12d142bb714f52f7842de6ab6c74cea0d735a4963fc70fe4ba6d9d7e3c27ece875b2a7230b3752652aa3ad9797958291b
  // 0x44Aa7e13893c929Cbcf8f1966Db7aa47eA80924A
  // 0xc3597245657ee3d7ad4440b76f59b8bde36fce29896c3b08549e7ba4e98257741169cd7d8ec206081b3187425760c95f49f4c4ae44b5a8a047d25ff45271d3491b

  final recoverWallet = EthereumAddress.fromHex("0x26aefa70921946c9353ff80737fbcbe97e17df74");
  final newOwnerAddress = EthereumAddress.fromHex("0xc324629acd5938bf4201cf3062dd696aeb2b071b");
  final nonce = BigInt.from(2);

  // final newOwner =  Web3Helper.recoverKeys(
  //   "0x37c6d0d3fb69cfbddb4302a981e54d1c708a4de3b5d61b4c4b30db799a3ff8c2",
  // );
  // print('newOwner ${newOwner.address}');
  //
  // final nonce = await EIP4337Lib.getNonce(simpleWalletAddress, ethClient);
  // print(nonce);

  // final recoverOp = await Guardian.walletContract(ethClient, simpleWalletAddress)
  //     .transferOwner(nonce, newOwner.address, entryPointAddress, Goerli.paymasterAddress,
  //     BigInt.from(3000000000), BigInt.from(2000000000));

  final recoverOp = await Guardian.walletContract(ethClient, recoverWallet)
      .transferOwner(nonce, newOwnerAddress, entryPointAddress, Goerli.paymasterAddress,
      BigInt.from(15000000000), BigInt.from(10000000000));
  print(recoverOp);

  final recoverId = recoverOp.requestId(Goerli.entryPointAddress, Goerli.chainId);
  print(bytesToHex(recoverId, include0x: true));

  // final sign1 = await guardian1.signPersonalMessage(recoverId);
  // final sign2 = await guardian2.signPersonalMessage(recoverId);
  final sign1 = hexToBytes("0x0ca30c68bb2b21bb5cb9577dfd532fedd12d142bb714f52f7842de6ab6c74cea0d735a4963fc70fe4ba6d9d7e3c27ece875b2a7230b3752652aa3ad9797958291b");
  final sign2 = hexToBytes("0xc3597245657ee3d7ad4440b76f59b8bde36fce29896c3b08549e7ba4e98257741169cd7d8ec206081b3187425760c95f49f4c4ae44b5a8a047d25ff45271d3491b");
  print('guardian1 ${guardian1.address} sign1 ${bytesToHex(sign1, include0x: true)}');
  print('guardian2 ${guardian2.address} sign2 ${bytesToHex(sign2, include0x: true)}');

  final signerSigs = [
    [guardian2.address, sign2],
    [guardian1.address, sign1]
  ];

  final signPack = await packGuardiansSignByRequestId(requestId, signerSigs);
  print(bytesToHex(signPack));

}
