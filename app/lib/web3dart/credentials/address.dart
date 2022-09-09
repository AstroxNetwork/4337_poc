import 'dart:typed_data';
import 'package:collection/collection.dart';
import '../crypto/secp256k1.dart';
import '../utils/formatting.dart';
//import '../crypto/sha256.dart' as sha256;
import 'package:crypto/crypto.dart';
import 'package:agent_dart/agent_dart.dart' hide hexToBytes, bytesToHex;

/// Represents an Ethereum address.
class EthereumAddress {
  /// An ethereum address from the raw address bytes.
  const EthereumAddress(this.addressBytes)
      : assert(addressBytes.length == addressByteLength);

  /// Constructs an Ethereum address from a public key. The address is formed by
  /// the last 20 bytes of the keccak hash of the public key.
  static Future<EthereumAddress> fromPublicKey(Uint8List publicKey) async {
    return EthereumAddress(await publicKeyToAddress(publicKey));
  }

  /// Parses an Ethereum address from the hexadecimal representation. The
  /// representation must have a length of 20 bytes (or 40 hexadecimal chars),
  /// and can optionally be prefixed with "0x".
  ///
  /// If [enforceEip55] is true or the address has both uppercase and lowercase
  /// chars, the address must be valid according to [EIP 55](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-55.md).
  factory EthereumAddress.fromHex(String hex, {bool enforceEip55 = false}) {
    if (!_basicAddress.hasMatch(hex)) {
      throw ArgumentError.value(
        hex,
        'address',
        'Must be a hex string with a length of 40, optionally prefixed with "0x"',
      );
    }

    if (!enforceEip55 &&
        (hex.toUpperCase() == hex || hex.toLowerCase() == hex)) {
      return EthereumAddress(hexToBytes(hex));
    }

    // Validates as of EIP 55, https://ethereum.stackexchange.com/a/1379
    final address = strip0x(hex);
    final hash = bytesToHex(address.toLowerCase().plainToU8a());
    for (var i = 0; i < 40; i++) {
      // the nth letter should be uppercase if the nth digit of casemap is 1
      final hashedPos = int.parse(hash[i], radix: 16);
      if ((hashedPos > 7 && address[i].toUpperCase() != address[i]) ||
          (hashedPos <= 7 && address[i].toLowerCase() != address[i])) {
        throw ArgumentError(
          'Address has invalid case-characters and is'
          'thus not EIP-55 conformant, rejecting. Address was: $hex',
        );
      }
    }

    return EthereumAddress(hexToBytes(hex));
  }

  static final RegExp _basicAddress =
      RegExp(r'^(0x)?[0-9a-f]{40}', caseSensitive: false);

  /// The length of an ethereum address, in bytes.
  static const addressByteLength = 20;
  final Uint8List addressBytes;

  /// A hexadecimal representation of this address, padded to a length of 40
  /// characters or 20 bytes, and prefixed with "0x".
  String get hex =>
      bytesToHex(addressBytes, include0x: true, forcePadLength: 40);

  /// A hexadecimal representation of this address, padded to a length of 40
  /// characters or 20 bytes, but not prefixed with "0x".
  String get hexNo0x =>
      bytesToHex(addressBytes, include0x: false, forcePadLength: 40);

  /// Returns this address in a hexadecimal representation, like with [hex].
  /// The hexadecimal characters A-F in the address will be in lower- or
  /// uppercase depending on [EIP 55](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-55.md).
  String get hexEip55 {
    // https://eips.ethereum.org/EIPS/eip-55#implementation

    final eip55 = toChecksumAddress(hexNo0x);
    return '0x$eip55';
  }

  @override
  String toString() => hex;

  @override
  bool operator ==(other) {
    return identical(this, other) ||
        (other is EthereumAddress &&
            const ListEquality().equals(addressBytes, other.addressBytes));
  }

  @override
  int get hashCode {
    return hex.hashCode;
  }
}

String toChecksumAddress(String address) {
  String stripAddress = strip0x(address.toLowerCase());

  final hash = sha256.convert(stripAddress.toU8a()).toString();
  String ret = '0x';

  BigInt v = hash.hexToBn();

  for (int i = 0; i < stripAddress.length; i++) {
    if ('0123456789'.contains(stripAddress[i])) {
      ret += stripAddress[i];
    } else {
      var checker = v & BigInt.from(2).pow(BigInt.from(255 - 6 * i).toInt());
      ret += checker >= BigInt.from(1)
          ? stripAddress[i].toUpperCase()
          : stripAddress[i].toLowerCase();
    }
  }

  return ret;
}
