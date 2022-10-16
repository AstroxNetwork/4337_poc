import 'dart:typed_data';

import 'package:app/eip4337lib/entity/user_operation.dart';
import 'package:app/web3dart/web3dart.dart';

import '../contracts/simpleWallet.dart';

class Guardian {
  const Guardian(this.web3, this.contract);

  final Web3Client web3;
  final DeployedContract contract;

  factory Guardian.walletContract(Web3Client web3, EthereumAddress address) {
    final contract = DeployedContract(SoulWallet().ABI, address);
    return Guardian(web3, contract);
  }

  Future<UserOperation> _guardian(
    BigInt nonce,
    EthereumAddress entryPointAddress,
    EthereumAddress paymasterAddress,
    BigInt maxFeePerGas,
    BigInt maxPriorityFeePerGas,
    Uint8List callData,
  ) async {
    final userOperation = UserOperation();
    userOperation.sender = contract.address;
    userOperation.nonce = nonce;
    userOperation.paymaster = paymasterAddress;
    userOperation.maxFeePerGas = maxFeePerGas;
    userOperation.maxPriorityFeePerGas = maxPriorityFeePerGas;
    userOperation.callData = callData;
    userOperation.verificationGas = BigInt.from(153600);
    userOperation.callGas = BigInt.from(94979);
    // final gasEstmated = await userOperation.estimateGas(
    //   web3,
    //   entryPointAddress,
    // );
    // if (!gasEstmated) {
    //   throw Exception("gasEstmated error");
    // }
    return userOperation;
  }

  Future<UserOperation> grantGuardianRequest(
    BigInt nonce,
    EthereumAddress guardianAddress,
    EthereumAddress entryPointAddress,
    EthereumAddress paymasterAddress,
    BigInt maxFeePerGas,
    BigInt maxPriorityFeePerGas,
  ) async {
    final grantGuardianRequest = contract.function('grantGuardianRequest');
    final callData = grantGuardianRequest.encodeCall([guardianAddress]);
    return _guardian(
      nonce,
      entryPointAddress,
      paymasterAddress,
      maxFeePerGas,
      maxPriorityFeePerGas,
      callData,
    );
  }

  Future<UserOperation> revokeGuardianRequest(
    BigInt nonce,
    EthereumAddress guardianAddress,
    EthereumAddress entryPointAddress,
    EthereumAddress paymasterAddress,
    BigInt maxFeePerGas,
    BigInt maxPriorityFeePerGas,
  ) async {
    final grantGuardianRequest = contract.function('revokeGuardianRequest');
    final callData = grantGuardianRequest.encodeCall([guardianAddress]);
    return _guardian(
      nonce,
      entryPointAddress,
      paymasterAddress,
      maxFeePerGas,
      maxPriorityFeePerGas,
      callData,
    );
  }

  Future<UserOperation> deleteGuardianRequest(
    BigInt nonce,
    EthereumAddress guardianAddress,
    EthereumAddress entryPointAddress,
    EthereumAddress paymasterAddress,
    BigInt maxFeePerGas,
    BigInt maxPriorityFeePerGas,
  ) async {
    final grantGuardianRequest = contract.function('deleteGuardianRequest');
    final callData = grantGuardianRequest.encodeCall([guardianAddress]);
    return _guardian(
      nonce,
      entryPointAddress,
      paymasterAddress,
      maxFeePerGas,
      maxPriorityFeePerGas,
      callData,
    );
  }

  Future<UserOperation> revokeGuardianConfirmation(
    BigInt nonce,
    EthereumAddress guardianAddress,
    EthereumAddress entryPointAddress,
    EthereumAddress paymasterAddress,
    BigInt maxFeePerGas,
    BigInt maxPriorityFeePerGas,
  ) async {
    final grantGuardianRequest =
        contract.function('revokeGuardianConfirmation');
    final callData = grantGuardianRequest.encodeCall([guardianAddress]);
    return _guardian(
      nonce,
      entryPointAddress,
      paymasterAddress,
      maxFeePerGas,
      maxPriorityFeePerGas,
      callData,
    );
  }

  Future<UserOperation> transferOwner(
    BigInt nonce,
    EthereumAddress newOwner,
    EthereumAddress entryPointAddress,
    EthereumAddress paymasterAddress,
    BigInt maxFeePerGas,
    BigInt maxPriorityFeePerGas,
  ) async {
    final grantGuardianRequest = contract.function('transferOwner');
    final callData = grantGuardianRequest.encodeCall([newOwner]);
    return _guardian(
      nonce,
      entryPointAddress,
      paymasterAddress,
      maxFeePerGas,
      maxPriorityFeePerGas,
      callData,
    );
  }
}
