import 'package:app/web3dart/contracts.dart';
import 'package:app/web3dart/credentials.dart';

import 'define/address.dart';
import 'entity/user_operation.dart';

class IContract {
  AbiType<List<dynamic>> ABI;
  String bytecode;
  IContract(this.ABI, this.bytecode);
}

class EIP4337Lib {
  static String getWalletCode(String entryPoint, String payMaster, String owner, String token) {
    // deploy wallet bytecode
    var simpleWalletBytecode = "";
    // const simpleWalletBytecode = new (Web3Helper.new().web3).eth.Contract(SimpleWalletContract.ABI).deploy({
    //   data: SimpleWalletContract.bytecode,
    //   arguments: [
    //     entryPointAddress,
    //     ownerAddress,
    //     tokenAddress,
    //     payMasterAddress
    //   ]
    // }).encodeABI();
    return simpleWalletBytecode;
  }

  static String calculateWalletAddressByCode(IContract initContract,
      List<AbiType> initArgs, BigInt salt,
      {String create2Factory = create2Factory}) {
    return '';
  }

  static String calculateWalletAddress(String entryPoint, String owner,
      String token, String payMaster,
      BigInt salt, {String create2Factory = create2Factory}) {
    return '';
    // return EIP4337Lib.calculateWalletAddressByCode(
    //     SimpleWalletContract,
    //     [entryPointAddress, ownerAddress, tokenAddress, payMasterAddress],
    //     salt,
    //     create2Factory
    // );
  }

  static String calculateWalletAddressByCodeHash(String initCodeHash, [int salt = 0, String create2Factory = create2Factory]) {
    return '';
    // const saltBytes32 = hexZeroPad(hexlify(salt), 32);
    // return getCreate2Address(create2Factory, saltBytes32, initCodeHash);
  }

  static UserOperation activateWalletOp(String entryPoint, String payMaster, String owner, String token,
      BigInt maxFeePerGas, BigInt maxPriorityFeePerGas, [int salt = 0, String create2Factory = create2Factory]) {
    final initCodeWithArgs = getWalletCode(entryPoint, payMaster, owner, token);
    // const initCodeHash = keccak256(initCodeWithArgs);
    const initCodeHash = '';
    final walletAddress = calculateWalletAddressByCodeHash(initCodeHash, salt, create2Factory);
    final userOperation = UserOperation();
    userOperation.nonce = BigInt.from(salt);//0;
    userOperation.sender = walletAddress;
    userOperation.paymaster = payMaster;
    userOperation.maxFeePerGas = maxFeePerGas;
    userOperation.maxPriorityFeePerGas = maxPriorityFeePerGas;
    userOperation.initCode = initCodeWithArgs;
    userOperation.verificationGas = BigInt.from(100000 + 3200 + 200 * userOperation.initCode.length);
    userOperation.callGas = BigInt.zero;
    userOperation.callData = "0x";
    return userOperation;
  }

  static BigInt getNonce(String walletAddress, String defaultBlock) {
    return BigInt.zero;
    // const code = await web3.eth.getCode(walletAddress, defaultBlock);
    // // check contract is exist
    // if (code === '0x') {
    //   return 0;
    // } else {
    //   const contract = new web3.eth.Contract([{ "inputs": [], "name": "nonce", "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }], "stateMutability": "view", "type": "function" }], walletAddress);
    //   const nonce = await contract.methods.nonce().call();
    //   // try parse to number
    //   const nextNonce = parseInt(nonce, 10);
    //   if (isNaN(nextNonce)) {
    //     throw new Error('nonce is not a number');
    //   }
    //   return nextNonce;
    // }
  }
}





