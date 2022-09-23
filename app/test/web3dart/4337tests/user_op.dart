
class UserOperation {
  const UserOperation(this.sender);
  final String sender;
  final BigInt nonce;
  final String initCode;
  final String callData;
  final BigInt callGas;
  final BigInt verificationGas;
  final BigInt preVerificationGas;
  final BigInt maxFeePerGas;
  final BigInt maxPriorityFeePerGas;
  final String paymaster;
  final String paymasterData;
  final String signature;

  
}