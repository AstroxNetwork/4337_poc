
import 'dart:ffi';
import 'dart:typed_data';


import 'package:app/eip4337lib/context/context.dart';
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
    var encoded = bytesToHex(tupleEncode(userOpType, op.toTuple()));
    encoded = '0x${encoded.substring(0, encoded.length - 64)}';
    return encoded;
  }
  return '';
}

Uint8List getRequestId(UserOperation op, EthereumAddress entryPointAddress, BigInt chainId) {
  final userOpHash = keccak256(hexToBytes(packUserOp(op)));
  // print('userOpHash ${bytesToHex(userOpHash, include0x: true)}');
  const tuple = TupleType([
    FixedBytes(32),
    AddressType(),
    UintType(),
  ]);
  return keccak256(tupleEncode(tuple, [userOpHash, entryPointAddress, chainId]));
}

// Uint8List toUint8List(String st) {
//   return Uint8List.fromList(st.codeUnits);
// }

Uint8List tupleEncode(AbiType<List<dynamic>> tuple, List data) {
  final buffer = LengthTrackingByteSink();
  tuple.encode(data, buffer);
  return buffer.asBytes();
}

// enum SignatureMode {
//   owner, // 0
//   guardians, // 1
// }

Uint8List signUserOpWithPersonalSign(EthereumAddress signAddress, Uint8List signature) {
  const tuple = TupleType([
    UintType(length: 8),
    DynamicLengthArray(type: TupleType([
      AddressType(),
      DynamicBytes(),
    ]))
  ]);
  return tupleEncode(tuple, [BigInt.zero, [[signAddress, signature]]]);
}

/// TODO
Future<String> _signRequestId(Uint8List message, String privateKey) async {
  Credentials cred = Web3Helper.recoverKeys(privateKey);
  // _messagePrefix = '\u0019Ethereum Signed Message:\n'
  var signed =  await cred.signPersonalMessage(message);
  return String.fromCharCodes(signed);
}

Future<String> _signUserOp(UserOperation op, EthereumAddress entryPoint, BigInt chainId, String privateKey) async {
  final message = getRequestId(op, entryPoint, chainId);
  return await _signRequestId(message, privateKey);
}

Future<Uint8List> signUserOp(UserOperation op, EthereumAddress entryPoint, BigInt chainId, String privateKey) async {
  final sign = await _signUserOp(op, entryPoint, chainId, privateKey);
  const tuple = TupleType([
    UintType(length: 8),
    DynamicLengthArray(type: TupleType([
      AddressType(),
      DynamicBytes(),
    ]))
  ]);
  return tupleEncode(tuple, [BigInt.zero, [WalletContext.getInstance().account, sign]]);
}



Future<String> packGuardiansSignByRequestId(String requestId, List<String> signatures, [String? walletAddress]) async{
  ///
  return '';
}

String payMasterSignHash(UserOperation op) {
  // keccak256(op.toTuple())
  return '';
}


