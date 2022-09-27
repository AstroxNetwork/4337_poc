
import 'dart:ffi';
import 'dart:typed_data';


import 'package:app/web3dart/contracts.dart';
import 'package:app/web3dart/crypto.dart';
import 'package:app/web3dart/credentials.dart';
import 'package:app/web3dart/crypto/formatting.dart';
import 'package:app/web3dart/utils/length_tracking_byte_sink.dart';

import '../entity/user_operation.dart';
import 'helper.dart';

String packUserOp(UserOperation op, [bool forSignature = true]) {
  if (forSignature) {
    const userOpType = TupleType([
      AddressType(),
      UintType(),
      DynamicBytes(),
      DynamicBytes(),
      UintType(),
      UintType(),
      UintType(),
      UintType(),
      UintType(),
      AddressType(),
      DynamicBytes(),
      DynamicBytes(),
    ]);
    var encoded = tupleEncode(userOpType, op.toTuple());
    encoded = '0x${encoded.substring(66, encoded.length - 64)}';
    return encoded;
  }
  return '';
}

String getRequestId(UserOperation op, String entryPoint, BigInt chainId) {
  final userOpHash = keccak256(hexToBytes(packUserOp(op)));
  final entryPointAddress = EthereumAddress.fromHex(entryPoint);
  const tuple = TupleType([
    FixedBytes(32),
    AddressType(),
    UintType(),
  ]);
  var enc = tupleEncode(tuple, [userOpHash, entryPointAddress, chainId]);
  return enc;
}

// Uint8List toUint8List(String st) {
//   return Uint8List.fromList(st.codeUnits);
// }

String tupleEncode(AbiType<List<dynamic>> tuple, List data) {
  final buffer = LengthTrackingByteSink();
  tuple.encode(data, buffer);
  return bytesToHex(buffer.asBytes(), include0x: false);
}

enum SignatureMode {
  owner,
  guardians,
}

/// TODO
Future<String> _signRequestId(String message, String privateKey) async {
  Credentials cred = Web3Helper.recoverKeys(privateKey);
  // _messagePrefix = '\u0019Ethereum Signed Message:\n'
  var signed =  await cred.signPersonalMessage(hexToBytes(message));
  return String.fromCharCodes(signed);
}

Future<String> _signUserOp(UserOperation op, String entryPoint, BigInt chainId, String privateKey) async {
  final message = getRequestId(op, entryPoint, chainId);
  return await _signRequestId(message, privateKey);
}

Future<String> signUserOp(UserOperation op, String entryPoint, BigInt chainId, String privateKey) async {
  final sign = await _signUserOp(op, entryPoint, chainId, privateKey);
  const tuple = TupleType([
    UintType(length: 8),
    DynamicLengthArray(type: TupleType([
      AddressType(),
      DynamicBytes(),
    ]))
  ]);
  return tupleEncode(tuple, [SignatureMode.owner, [Web3Helper.credentials().extractAddress(), sign]]);
}

Future<String> signUserOpWithPersonalSign(String signer, String signature) async {
  final signAddress = EthereumAddress.fromHex(signer);
  const tuple = TupleType([
    UintType(length: 8),
    DynamicLengthArray(type: TupleType([
      AddressType(),
      DynamicBytes(),
    ]))
  ]);
  return tupleEncode(tuple, [SignatureMode.owner, [signAddress, signature]]);
}

Future<String> packGuardiansSignByRequestId(String requestId, List<String> signatures, [String? walletAddress]) async{
  ///
  return '';
}

String payMasterSignHash(UserOperation op) {
  // keccak256(op.toTuple())
  return '';
}


