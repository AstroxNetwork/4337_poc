import 'package:app/eip4337lib/contracts/IContract.dart';
import 'package:app/eip4337lib/contracts/simpleWallet.dart';
import 'package:app/eip4337lib/utils/user_op.dart';
import 'package:app/web3dart/contracts.dart';
import 'package:app/web3dart/credentials.dart';
import 'package:app/web3dart/crypto.dart';
import 'package:app/web3dart/web3dart.dart';

import 'dart:typed_data';
import 'define/address.dart';
import 'entity/user_operation.dart';

final Create2Factory = EthereumAddress.fromHex('0xce0042B868300000d44A59004Da54A005ffdcf9f');

class EIP4337Lib {

  static String calculateWalletAddress(
      EthereumAddress entryPointAddress,
      EthereumAddress ownerAddress,
      EthereumAddress tokenAddress,
      EthereumAddress payMasterAddress,
      BigInt salt) {
    return EIP4337Lib.calculateWalletAddressByCode(
        SoulWallet(),
        [entryPointAddress, ownerAddress, tokenAddress, payMasterAddress],
        salt
    );
  }

  static String getWalletCodeWithArgs(IContract contract, List<dynamic> initArgs) {
    var initCodeWithArgs = contract.bytecode;
    final walletConstructor = contract.ABI.functions.singleWhere((f) => f.isConstructor);
    final initParamsEncoded = bytesToHex(walletConstructor.encodeCall(initArgs), include0x: false);
    initCodeWithArgs += initParamsEncoded;
    // print('initCodeWithArgs: $initCodeWithArgs');
    return initCodeWithArgs;
  }

  static String calculateWalletAddressByCode(IContract contract, List<dynamic> initArgs, BigInt salt) {
    final initCodeWithArgs = getWalletCodeWithArgs(contract, initArgs);
    final initCodeHash = keccak256(hexToBytes(initCodeWithArgs));
    // print('initCodeHash: ${bytesToHex(initCodeHash, include0x: true)}');
    return calculateWalletAddressByCodeHash(initCodeHash, salt);
  }

  static String calculateWalletAddressByCodeHash(Uint8List initCodeHash, BigInt salt) {
    final saltBytes32 = bytesToHex(unsignedIntToBytes(salt), forcePadLength: 64, include0x: true, padToEvenLength: true);
    // print('saltBytes32: $saltBytes32');
    return getCreate2Address(Create2Factory, saltBytes32, initCodeHash);
  }

  // create2
  static String getCreate2Address(EthereumAddress factory, String saltBytes32, Uint8List initCodeHash) {
    final salt = hexToBytes(saltBytes32);
    // print('getCreate2Address: len ${salt.length}, ${initCodeHash.length}');
    final input = '0xff' + factory.hexNo0x + bytesToHex(salt, include0x: false) + bytesToHex(initCodeHash, include0x: false);
    return bytesToHex(keccak256(hexToBytes(input)).sublist(12), include0x: true);
  }

  static UserOperation activateWalletOp(
      EthereumAddress entryPointAddress, EthereumAddress payMasterAddress,
      EthereumAddress ownerAddress, EthereumAddress tokenAddress,
      BigInt maxFeePerGas, BigInt maxPriorityFeePerGas, BigInt salt) {
    final initCodeWithArgs = getWalletCodeWithArgs(SoulWallet(),
      [entryPointAddress, ownerAddress, tokenAddress, payMasterAddress],);
    final initCodeHash = keccak256(hexToBytes(initCodeWithArgs));
    final walletAddress = calculateWalletAddressByCodeHash(initCodeHash, salt);
    final userOperation = UserOperation();
    userOperation.nonce = salt;//0;
    userOperation.sender = EthereumAddress.fromHex(walletAddress);
    userOperation.paymaster = payMasterAddress;
    userOperation.maxFeePerGas = maxFeePerGas;
    userOperation.maxPriorityFeePerGas = maxPriorityFeePerGas;
    userOperation.initCode = hexToBytes(initCodeWithArgs);
    userOperation.verificationGas = BigInt.from(100000 + 3200 + 400 * userOperation.initCode.length + 400);
    userOperation.callGas = BigInt.zero;
    userOperation.callData = Uint8List(0);
    return userOperation;
  }



  static Future<BigInt> getNonce(EthereumAddress walletAddress, Web3Client web3) async{
    final code = await web3.getCode(walletAddress);
    var nonce = BigInt.zero;
    if (code.isNotEmpty) {
      final SoulWalletContract = DeployedContract(SoulWallet().ABI, walletAddress);
      final getNonce = SoulWalletContract.function("nonce");
      final response = await web3.call(contract: SoulWalletContract, function: getNonce, params: []);
      print(response);
      nonce = response[0] as BigInt;
    }
    return nonce;
  }
}





