import 'dart:typed_data';

import 'package:app/eip4337lib/entity/user_operation.dart';
import 'package:app/web3dart/web3dart.dart';
import 'package:get/get.dart';

import '../contracts/tokens.dart';

import 'package:app/web3dart/contracts.dart';
import 'package:app/web3dart/credentials.dart';

Future<UserOperation?> createOp(Web3Client web3,
    EthereumAddress entryPointAddress, EthereumAddress paymasterAddress,
    EthereumAddress walletAddress, BigInt nonce,
    BigInt maxFeePerGas, BigInt maxPriorityFeePerGas,
    EthereumAddress callContract, Uint8List encoded, BigInt value) async {
  final userOperation = UserOperation();
  userOperation.sender = walletAddress;
  userOperation.nonce = nonce;
  userOperation.paymaster = paymasterAddress;
  userOperation.maxFeePerGas = maxFeePerGas;
  userOperation.maxPriorityFeePerGas = maxPriorityFeePerGas;
  userOperation.callData = execFromEntryPoint.encodeCall([
    callContract, value, encoded
  ]);
  final gasEstmated = await userOperation.estimateGas(web3, entryPointAddress);
  if (!gasEstmated) {
    return null;
  }
  return userOperation;
}

class ETH {
  final Web3Client web3;
  ETH(this.web3);

  Future<UserOperation?> transfer(EthereumAddress walletAddress, BigInt nonce,
      EthereumAddress entryPointAddress, EthereumAddress paymasterAddress,
      BigInt maxFeePerGas, BigInt maxPriorityFeePerGas,
      EthereumAddress to, BigInt value) async {
    return createOp(web3, entryPointAddress, paymasterAddress, walletAddress, nonce,
        maxFeePerGas, maxPriorityFeePerGas, to, Uint8List(0), value);
  }

}

class ERC20 {
  final Web3Client web3;
  final DeployedContract contract;
  ERC20(this.web3, this.contract);

  factory ERC20.getContract(Web3Client web3, EthereumAddress address) {
    final contract = DeployedContract(ERC20ABI, address);
    return ERC20(web3, contract);
  }

  Future<UserOperation?> approve(EthereumAddress walletAddress, BigInt nonce,
      EthereumAddress entryPointAddress, EthereumAddress paymasterAddress,
      BigInt maxFeePerGas, BigInt maxPriorityFeePerGas,
      EthereumAddress spender, BigInt value) async {
      final approve = contract.function('approve');
      final callData = approve.encodeCall([spender, value]);
      return createOp(web3, entryPointAddress, paymasterAddress, walletAddress, nonce,
          maxFeePerGas, maxPriorityFeePerGas, contract.address, callData, BigInt.zero);
  }

  Future<UserOperation?> transfer(EthereumAddress walletAddress, BigInt nonce,
      EthereumAddress entryPointAddress, EthereumAddress paymasterAddress,
      BigInt maxFeePerGas, BigInt maxPriorityFeePerGas,
      EthereumAddress to, BigInt value) async {
    final approve = contract.function('transfer');
    final callData = approve.encodeCall([to, value]);
    return createOp(web3, entryPointAddress, paymasterAddress, walletAddress, nonce,
        maxFeePerGas, maxPriorityFeePerGas, contract.address, callData, BigInt.zero);
  }

  Future<UserOperation?> transferFrom(EthereumAddress walletAddress, BigInt nonce,
      EthereumAddress entryPointAddress, EthereumAddress paymasterAddress,
      BigInt maxFeePerGas, BigInt maxPriorityFeePerGas,
      EthereumAddress from, EthereumAddress to, BigInt value) async {
    final approve = contract.function('transferFrom');
    final callData = approve.encodeCall([from, to, value]);
    return createOp(web3, entryPointAddress, paymasterAddress, walletAddress, nonce,
        maxFeePerGas, maxPriorityFeePerGas, contract.address, callData, BigInt.zero);
  }
}


class ERC721 {
  final Web3Client web3;
  final DeployedContract contract;
  ERC721(this.web3, this.contract);

  factory ERC721.getContract(Web3Client web3, EthereumAddress address) {
    final contract = DeployedContract(ERC721ABI, address);
    return ERC721(web3, contract);
  }

  Future<UserOperation?> approve(EthereumAddress walletAddress, BigInt nonce,
      EthereumAddress entryPointAddress, EthereumAddress paymasterAddress,
      BigInt maxFeePerGas, BigInt maxPriorityFeePerGas,
      EthereumAddress spender, BigInt tokenId) async {
    final approve = contract.function('approve');
    final callData = approve.encodeCall([spender, tokenId]);
    return createOp(web3, entryPointAddress, paymasterAddress, walletAddress, nonce,
        maxFeePerGas, maxPriorityFeePerGas, contract.address, callData, BigInt.zero);
  }

  Future<UserOperation?> transfer(EthereumAddress walletAddress, BigInt nonce,
      EthereumAddress entryPointAddress, EthereumAddress paymasterAddress,
      BigInt maxFeePerGas, BigInt maxPriorityFeePerGas,
      EthereumAddress to, BigInt tokenId) async {
    final approve = contract.function('transfer');
    final callData = approve.encodeCall([to, tokenId]);
    return createOp(web3, entryPointAddress, paymasterAddress, walletAddress, nonce,
        maxFeePerGas, maxPriorityFeePerGas, contract.address, callData, BigInt.zero);
  }

  Future<UserOperation?> transferFrom(EthereumAddress walletAddress, BigInt nonce,
      EthereumAddress entryPointAddress, EthereumAddress paymasterAddress,
      BigInt maxFeePerGas, BigInt maxPriorityFeePerGas,
      EthereumAddress from, EthereumAddress to, BigInt tokenId) async {
    final approve = contract.function('transferFrom');
    final callData = approve.encodeCall([from, to, tokenId]);
    return createOp(web3, entryPointAddress, paymasterAddress, walletAddress, nonce,
        maxFeePerGas, maxPriorityFeePerGas, contract.address, callData, BigInt.zero);
  }

  Future<UserOperation?> safeTransferFrom(EthereumAddress walletAddress, BigInt nonce,
      EthereumAddress entryPointAddress, EthereumAddress paymasterAddress,
      BigInt maxFeePerGas, BigInt maxPriorityFeePerGas,
      EthereumAddress from, EthereumAddress to, BigInt tokenId) async {
    final approve = contract.function('safeTransferFrom');
    final callData = approve.encodeCall([from, to, tokenId]);
    return createOp(web3, entryPointAddress, paymasterAddress, walletAddress, nonce,
        maxFeePerGas, maxPriorityFeePerGas, contract.address, callData, BigInt.zero);
  }

  Future<UserOperation?> setApprovalForAll(EthereumAddress walletAddress, BigInt nonce,
      EthereumAddress entryPointAddress, EthereumAddress paymasterAddress,
      BigInt maxFeePerGas, BigInt maxPriorityFeePerGas,
      EthereumAddress operator, bool approved) async {
    final approve = contract.function('setApprovalForAll');
    final callData = approve.encodeCall([operator, approved]);
    return createOp(web3, entryPointAddress, paymasterAddress, walletAddress, nonce,
        maxFeePerGas, maxPriorityFeePerGas, contract.address, callData, BigInt.zero);
  }
}