import 'dart:async';

import 'package:app/eip4337lib/EIP4337Lib.dart';
import 'package:app/eip4337lib/define/abi.dart';
import 'package:app/eip4337lib/define/address.dart';
import 'package:app/eip4337lib/entity/user_operation.dart';
import 'package:app/eip4337lib/utils/helper.dart';
import 'package:app/eip4337lib/utils/send.dart';
import 'package:app/web3dart/web3dart.dart';
import 'package:app/web3dart/crypto.dart';

import '../utils/tokens.dart';

// WalletContext.getInstance()
class WalletContext {
  Web3Client web3;
  EthPrivateKey account;  // 本地账户
  EthereumAddress? walletAddress;
  WalletContext(this.web3, this.account);
  static WalletContext? _instance; // 记录本地账户

  static WalletContext getInstance() {
    if (_instance == null) {
      throw(Exception("need create or recover"));
    }
    return _instance!;
  }

  // 创建本地账户
  static void createAccount(Web3Client web3) {
      final privateKey = Web3Helper.generateKey();
      _instance = WalletContext(web3, privateKey);
  }

  // 从keystore本地恢复
  static void recoverKeystore(Web3Client web3, String json, String password) {
    final privateKey = Web3Helper.recoverWallet(json, password);
    _instance = WalletContext(web3, privateKey);
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
  // static void recoverPrivateKey(Web3Client web3, String priKey) {
  //   final privateKey = Web3Helper.recoverKeys(priKey);
  //   _instance = WalletContext(web3, privateKey);
  // }

  // 本地账户生成keystore，本地保存
  String toKeystore(String password) {
    final wallet = Web3Helper.createWallet(account, password);
    return wallet.toJson();
  }

  // 生成钱包地址，记录在context
  void setWalletAddress(String wallet) {
    //final wallet = generateWalletAddress(account.address, BigInt.zero);
    walletAddress = EthereumAddress.fromHex(wallet);
  }

  String generateWalletAddress(EthereumAddress ownerAddress, BigInt salt) {
    final walletAddress = EIP4337Lib.calculateWalletAddress(Goerli.entryPointAddress,
        ownerAddress, Goerli.wethAddress, Goerli.paymasterAddress, salt);
    return walletAddress;
  }

  // 取得eth余额
  Future<double> getEthBalance() async {
    final amount = await web3.getBalance(walletAddress!);
    return amount.getValueInUnit(EtherUnit.ether);
  }

  // 取得weth余额
  Future<double> getWEthBalance() async {
    final wethContract = DeployedContract(ERC20ABI, Goerli.wethAddress);
    final balanceOf = wethContract.function('balanceOf');
    final response = await web3.call(contract: wethContract, function: balanceOf, params: [walletAddress]);
    final amount = EtherAmount.fromUnitAndValue(EtherUnit.wei, response[0]);
    return amount.getValueInUnit(EtherUnit.ether);
  }

  // 取得gasPrice，double
  Future<double> getGasPrice() async {
    final amount = await web3.getGasPrice();
    return amount.getValueInUnit(EtherUnit.gwei);
  }

  // 取得gasPrice, BigInt, eth = 10^18 wei
  Future<BigInt> getGasPriceBI() async {
    final amount = await web3.getGasPrice();
    return amount.getInWei;
  }

  // walletaddress是否init
  Future<String> getWalletType() async {
    final res = await web3.getCode(walletAddress!);
    return res.isNotEmpty ? "contract" : "eoa";
  }

  // 激活钱包
  void activateWallet() async {
    final currentFee = (await getGasPriceBI()) * BigInt.from(3);
    final activateOp = EIP4337Lib.activateWalletOp(Goerli.entryPointAddress,
        Goerli.paymasterAddress, account.address, Goerli.wethAddress,
        currentFee, BigInt.from(10).pow(10), BigInt.zero);

    _executeOperation(activateOp);
  }

  // 执行和sendOp
  void _executeOperation(UserOperation op) async {
    final requestId = op.requestId(Goerli.entryPointAddress, Goerli.chainId);
    final signature = await account.signPersonalMessage(requestId);
    op.signWithSignature(account.address, signature);
    Send.sendOpWait(web3, op, Goerli.entryPointAddress, Goerli.chainId);
  }

  // 发送eth
  void sendETH(EthereumAddress to, BigInt amount) async {
    final currentFee = (await getGasPriceBI()) * BigInt.from(3);
    final nonce = await EIP4337Lib.getNonce(walletAddress!, web3);
    final op = await ETH(web3).transfer(walletAddress!, nonce, Goerli.entryPointAddress,
        Goerli.paymasterAddress, currentFee, BigInt.from(10).pow(10), to, amount);
    _executeOperation(op!);
  }

  // 发送erc20
  void sendERC20(EthereumAddress tokenAddress, EthereumAddress to, BigInt amount) async {
    final currentFee = (await getGasPriceBI()) * BigInt.from(3);
    final nonce = await EIP4337Lib.getNonce(walletAddress!, web3);
    final contract = DeployedContract(ERC20ABI, tokenAddress);
    final op = await ERC20(web3, contract).transfer(walletAddress!, nonce, Goerli.entryPointAddress,
        Goerli.paymasterAddress, currentFee, BigInt.from(10).pow(10), to, amount);
    _executeOperation(op!);
  }

}