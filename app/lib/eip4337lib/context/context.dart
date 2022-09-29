import 'dart:async';

import 'package:app/eip4337lib/EIP4337Lib.dart';
import 'package:app/eip4337lib/define/abi.dart';
import 'package:app/eip4337lib/define/address.dart';
import 'package:app/eip4337lib/entity/user_operation.dart';
import 'package:app/eip4337lib/utils/helper.dart';
import 'package:app/eip4337lib/utils/send.dart';
import 'package:app/web3dart/web3dart.dart';

import '../utils/tokens.dart';

class WalletContext {
  Web3Client web3;
  EthPrivateKey account;
  EthereumAddress? walletAddress;
  WalletContext(this.web3, this.account);
  static WalletContext? _instance;

  static WalletContext getInstance() {
    if (_instance == null) {
      throw(Exception("No Wallet"));
    }
    return _instance!;
  }

  static void createWallet(Web3Client web3) {
      final account = Web3Helper.generateKey();
      _instance = WalletContext(web3, account);
  }

  static void replaceWallet(Web3Client web3) {
    final account = Web3Helper.generateKey();
    _instance = WalletContext(web3, account);
  }

  static void deleteWallet() {
    _instance = null;
  }

  static void recoverPrivateKey(Web3Client web3, String privateKey) {
    final account = Web3Helper.recoverKeys(privateKey);
    _instance = WalletContext(web3, account);
  }

  static void recoverKeystore(Web3Client web3, String json, String password) {
    final account = Web3Helper.recoverWallet(json, password);
    _instance = WalletContext(web3, account);
  }

  String generateWalletAddress(EthereumAddress ownerAddress, BigInt salt) {
    final walletAddress = EIP4337Lib.calculateWalletAddress(Ropsten.entryPointAddress,
        ownerAddress, Ropsten.wethAddress, Ropsten.paymasterAddress, salt);
    return walletAddress;
  }

  void setWalletAddress() {
    final wallet = generateWalletAddress(account.address, BigInt.zero);
    walletAddress = EthereumAddress.fromHex(wallet);
  }

  String toWalletJson(String password) {
    final wallet = Web3Helper.createWallet(account, password);
    return wallet.toJson();
  }

  Future<double> getEthBalance() async {
    final amount = await web3.getBalance(account.address);
    return amount.getValueInUnit(EtherUnit.ether);
  }

  Future<double> getGasPrice() async {
    final amount = await web3.getGasPrice();
    return amount.getValueInUnit(EtherUnit.gwei);
  }

  Future<BigInt> getGasPriceBI() async {
    final amount = await web3.getGasPrice();
    return amount.getInWei;
  }

  Future<String> getWalletType() async {
    final res = await web3.getCode(walletAddress!);
    return res.isNotEmpty ? "contract" : "eoa";
  }

  void executeOperation(UserOperation op) async {
    final requestId = op.requestId(Ropsten.entryPointAddress, Ropsten.chainId);
    final signature = await account.signPersonalMessage(requestId);
    op.signWithSignature(account.address, signature);
    Send.sendOpWait(web3, op, Ropsten.entryPointAddress, Ropsten.chainId);
  }

  void activateWallet() async {
    final currentFee = (await getGasPriceBI()) * BigInt.from(3);
    final activateOp = EIP4337Lib.activateWalletOp(Ropsten.entryPointAddress,
        Ropsten.paymasterAddress, account.address, Ropsten.wethAddress,
        currentFee, BigInt.from(10).pow(10), BigInt.zero);

    executeOperation(activateOp);
  }

  void sendETH(EthereumAddress to, BigInt amount) async {
    final currentFee = (await getGasPriceBI()) * BigInt.from(3);
    final nonce = await EIP4337Lib.getNonce(walletAddress!, web3);
    final op = await ETH(web3).transfer(walletAddress!, nonce, Ropsten.entryPointAddress,
        Ropsten.paymasterAddress, currentFee, BigInt.from(10).pow(10), to, amount);
    executeOperation(op!);
  }

  void sendERC20(EthereumAddress tokenAddress, EthereumAddress to, BigInt amount) async {
    final currentFee = (await getGasPriceBI()) * BigInt.from(3);
    final nonce = await EIP4337Lib.getNonce(walletAddress!, web3);
    final contract = DeployedContract(ERC20ABI, tokenAddress);
    final op = await ERC20(web3, contract).transfer(walletAddress!, nonce, Ropsten.entryPointAddress,
        Ropsten.paymasterAddress, currentFee, BigInt.from(10).pow(10), to, amount);
    executeOperation(op!);
  }

}