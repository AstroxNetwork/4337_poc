import 'dart:async';

import 'package:app/eip4337lib/EIP4337Lib.dart';
import 'package:app/eip4337lib/backend/request.dart';
import 'package:app/eip4337lib/contracts/entryPoint.dart';
import 'package:app/eip4337lib/define/abi.dart';
import 'package:app/eip4337lib/define/address.dart';
import 'package:app/eip4337lib/entity/user_operation.dart';
import 'package:app/eip4337lib/utils/guardian.dart';
import 'package:app/eip4337lib/utils/helper.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:app/eip4337lib/utils/send.dart';
import 'package:app/eip4337lib/utils/tokens.dart';
import 'package:app/eip4337lib/utils/user_op.dart';
import 'package:app/web3dart/web3dart.dart';

// WalletContext.getInstance()
class WalletContext {
  WalletContext(this.web3, this.account);

  final Web3Client web3;
  final EthPrivateKey account; // 本地账户

  EthereumAddress get walletAddress => _walletAddress;
  late EthereumAddress _walletAddress = EthereumAddress.fromHex(
    generateWalletAddress(account.address, BigInt.zero),
  );

  static WalletContext? _instance; // 记录本地账户

  static WalletContext getInstance() {
    if (_instance == null) {
      throw Exception('Need create or recover');
    }
    return _instance!;
  }

  // 创建本地账户
  static WalletContext createAccount([Web3Client? web3]) {
    final privateKey = Web3Helper.generateKey();
    LogUtil.d('generate ${privateKey.address.hex}');
    _instance = WalletContext(web3 ?? Web3Helper.client, privateKey);
    return _instance!;
  }

  // 从keystore本地恢复
  static WalletContext recoverKeystore(Web3Client web3, String json, String password) {
    final privateKey = Web3Helper.recoverWallet(json, password);
    LogUtil.d('recover ${privateKey.address.hex}');
    _instance = WalletContext(web3, privateKey);
    return _instance!;
  }

  // 替换本地账户
  // static void replaceAccount(Web3Client web3) {
  //   final privateKey = Web3Helper.generateKey();
  //   _instance = WalletContext(web3, privateKey);
  // }

  // 删除本地账户
  // static void deleteAccount() {
  //   _instance = null;
  // }

  // 从私钥恢复本地
  static WalletContext recoverPrivateKey(Web3Client web3, String priKey) {
    final privateKey = Web3Helper.recoverKeys(priKey);
    _instance = WalletContext(web3, privateKey);
    return _instance!;
  }

  // 本地账户生成keystore，本地保存
  String toKeystore(String password) {
    final wallet = Web3Helper.createWallet(account, password);
    return wallet.toJson();
  }

  String getEoaAddress() {
    return account.address.hex;
  }

  Future<String> getWalletAddress() async {
    Map params = {'key': account.address.hex};
    final response = await Request.getWalletAddress(params);
    final body = response.data!;
    return body['data']['wallet_address'];
  }

  static Future<String> getWalletAddressByEmail(String email) async {
    Map params = {'email': email};
    final response = await Request.getWalletAddress(params);
    final body = response.data!;
    return body['data']['wallet_address'];
  }

  // 生成钱包地址，记录在context
  void setWalletAddress(String wallet) {
    //final wallet = generateWalletAddress(account.address, BigInt.zero);
    _walletAddress = EthereumAddress.fromHex(wallet);
  }

  // // 生成钱包地址，记录在context
  // void setWalletAddressAutomatic() {
  //   final wallet = generateWalletAddress(account.address, BigInt.zero);
  //   walletAddress = EthereumAddress.fromHex(wallet);
  // }

  static String generateWalletAddress(
    EthereumAddress ownerAddress,
    BigInt salt,
  ) {
    final walletAddress = EIP4337Lib.calculateWalletAddress(
      Goerli.entryPointAddress,
      ownerAddress,
      Goerli.wethAddress,
      Goerli.paymasterAddress,
      salt,
    );
    return walletAddress;
  }

  // 取得eth余额
  Future<double> getEthBalance() async {
    final amount = await web3.getBalance(walletAddress);
    return amount.getValueInUnit(EtherUnit.ether);
  }

  // 取得weth余额
  Future<double> getWEthBalance() async {
    final wethContract = DeployedContract(ERC20ABI, Goerli.wethAddress);
    final balanceOf = wethContract.function('balanceOf');
    final response = await web3.call(
      contract: wethContract,
      function: balanceOf,
      params: [walletAddress],
    );
    final amount = EtherAmount.fromUnitAndValue(EtherUnit.wei, response[0]);
    return amount.getValueInUnit(EtherUnit.ether);
  }

  // 取得gasPrice，double
  Future<double> getGasPrice() async {
    final amount = await web3.getGasPrice();
    return amount.getValueInUnit(EtherUnit.gwei);
  }

  // 取得gasPrice, BigInt, eth = 10^18 wei
  BigInt getGasPriceBI() {
    return BigInt.from(5000000000);
  }

  // walletaddress是否init
  Future<bool> isWalletContract() async {
    final res = await web3.getCode(walletAddress);
    return res.isNotEmpty;
    // return res.isNotEmpty ? "contract" : "eoa";
  }

  // 激活钱包
  Future<String> activateWallet() async {
    final currentFee = getGasPriceBI() * Goerli.multiplier;
    final activateOp = EIP4337Lib.activateWalletOp(
      Goerli.entryPointAddress,
      Goerli.paymasterAddress,
      account.address,
      Goerli.wethAddress,
      currentFee,
      Goerli.priorityFee,
      BigInt.zero,
    );
    return _executeOperation(activateOp);
  }

  // 执行和sendOp
  Future<String> _executeOperation(UserOperation op) async {
    final requestId = op.requestId(Goerli.entryPointAddress, Goerli.chainId);
    final signature = await account.signPersonalMessage(requestId);
    op.signWithSignature(account.address, signature);
    LogUtil.d(op);
    final entryPointContract = DeployedContract(
      EntryPoint().ABI,
      Goerli.entryPointAddress,
    );
    final simulateValidation = entryPointContract.function(
      "simulateValidation",
    );
    final response = await web3.call(
      sender: Goerli.zeroAddress,
      contract: entryPointContract,
      function: simulateValidation,
      params: [op.toTuple()],
    );
    LogUtil.d('simulateValidation $response');
    return Send.sendOpWait(web3, op, Goerli.entryPointAddress, Goerli.chainId);
    // add tx to localstorage
  }

  // 发送eth
  Future<String> sendETH(EthereumAddress to, BigInt amount) async {
    final currentFee = getGasPriceBI() * Goerli.multiplier;
    final nonce = await EIP4337Lib.getNonce(walletAddress, web3);
    final op = await ETH(web3).transfer(
      walletAddress,
      nonce,
      Goerli.entryPointAddress,
      Goerli.paymasterAddress,
      currentFee,
      Goerli.priorityFee,
      to,
      amount,
    );
    return _executeOperation(op);
  }

  // 发送erc20
  Future<String> sendERC20(
    EthereumAddress tokenAddress,
    EthereumAddress to,
    BigInt amount,
  ) async {
    final currentFee = getGasPriceBI() * Goerli.multiplier;
    final nonce = await EIP4337Lib.getNonce(walletAddress, web3);
    final contract = DeployedContract(ERC20ABI, tokenAddress);
    final op = await ERC20(web3, contract).transfer(
      walletAddress,
      nonce,
      Goerli.entryPointAddress,
      Goerli.paymasterAddress,
      currentFee,
      Goerli.priorityFee,
      to,
      amount,
    );
    return _executeOperation(op);
  }

  Future<String> addGuardian(EthereumAddress guardianAddress) async {
    final currentFee = getGasPriceBI() * Goerli.multiplier;
    final nonce = await EIP4337Lib.getNonce(walletAddress, web3);
    final op = await Guardian.walletContract(
      web3,
      walletAddress,
    ).grantGuardianRequest(
      nonce,
      guardianAddress,
      Goerli.entryPointAddress,
      Goerli.paymasterAddress,
      currentFee,
      Goerli.priorityFee,
    );
    return _executeOperation(op);
  }

  Future<String> removeGuardian(EthereumAddress guardianAddress) async {
    final currentFee = getGasPriceBI() * Goerli.multiplier;
    final nonce = await EIP4337Lib.getNonce(walletAddress, web3);
    final op = await Guardian.walletContract(
      web3,
      walletAddress,
    ).revokeGuardianRequest(
      nonce,
      guardianAddress,
      Goerli.entryPointAddress,
      Goerli.paymasterAddress,
      currentFee,
      Goerli.priorityFee,
    );
    return _executeOperation(op);
  }

  Future<UserOperation> transferOwner(EthereumAddress newOwner) async {
    final currentFee = getGasPriceBI() * Goerli.multiplier;
    final nonce = await EIP4337Lib.getNonce(walletAddress, web3);
    final op = await Guardian.walletContract(
      web3,
      walletAddress,
    ).transferOwner(
      nonce,
      newOwner,
      Goerli.entryPointAddress,
      Goerli.paymasterAddress,
      currentFee,
      Goerli.priorityFee,
    );
    return op;
  }

  // singerSigs = [
  // [EthereumAddress, Uint8List],
  // [EthereumAddress, Uint8List]
  // ]
  Future<String> recoverWallet(
    EthereumAddress newOwner,
    List<dynamic> singerSigs,
  ) async {
    final recoveryOp = await transferOwner(newOwner);
    final requestId = recoveryOp.requestId(
      Goerli.entryPointAddress,
      Goerli.chainId,
    );

    final signPack = await packGuardiansSignByRequestId(requestId, singerSigs);
    recoveryOp.signature = signPack;

    final entryPointContract = DeployedContract(
      EntryPoint().ABI,
      Goerli.entryPointAddress,
    );
    LogUtil.d(recoveryOp);
    final simulateValidation = entryPointContract.function(
      "simulateValidation",
    );
    final response = await web3.call(
      sender: Goerli.zeroAddress,
      contract: entryPointContract,
      function: simulateValidation,
      params: [recoveryOp.toTuple()],
    );
    LogUtil.d('simulateValidation $response');
    return Send.sendOpWait(
      web3,
      recoveryOp,
      Goerli.entryPointAddress,
      Goerli.chainId,
    );
  }
}
