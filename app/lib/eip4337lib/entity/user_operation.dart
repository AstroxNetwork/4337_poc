
class TransactionInfo {
  String? from;
  String? to;
  String? data;
  TransactionInfo([this.from, this.to, this.data]);
}

class UserOperation {
  String sender = '';
  BigInt nonce = BigInt.from(0);
  String initCode = '0x';
  String callData = '0x';
  BigInt callGas = BigInt.from(0);
  BigInt verificationGas = BigInt.from(0);
  BigInt preVerificationGas = BigInt.from(0);
  BigInt maxFeePerGas = BigInt.from(0);
  BigInt maxPriorityFeePerGas = BigInt.from(0);
  String paymaster = '0x';
  String paymasterData = '0x';
  String signature = '0x';

  UserOperation clone() {
    UserOperation clone = new UserOperation();
    clone.sender = sender;
    clone.nonce = nonce;
    clone.initCode = initCode;
    clone.callData = callData;
    clone.callGas = callGas;
    clone.verificationGas = verificationGas;
    clone.preVerificationGas = preVerificationGas;
    clone.maxFeePerGas = maxFeePerGas;
    clone.maxPriorityFeePerGas = maxPriorityFeePerGas;
    clone.paymaster = paymaster;
    clone.paymasterData = paymasterData;
    clone.signature = signature;
    return clone;
  }

  List toTuple() {
    return [sender,nonce,initCode,callData,callGas,
      verificationGas,preVerificationGas,maxFeePerGas,maxPriorityFeePerGas,
      paymaster,paymasterData,signature];
  }

  Future<bool> estimateGas(String entryPointAddress, Function(TransactionInfo) estimateGasFunc) async {
    try {
      verificationGas = BigInt.from(150000);
      if (initCode.isNotEmpty) {
        verificationGas += BigInt.from(3200 + 200 * initCode.length);
      }
      callGas = await estimateGasFunc(TransactionInfo(
        entryPointAddress, sender, callData
      ));
      return true;
    } catch (e) {
      return false;
    }
  }




}