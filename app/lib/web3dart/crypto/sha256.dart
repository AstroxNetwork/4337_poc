import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:crypto/src/digest_sink.dart';
import 'package:agent_dart/agent_dart.dart';
import 'package:flutter/foundation.dart';

class SHA256 {
  late final DigestSink ds;
  late final ByteConversionSink sha;

  SHA256() {
    ds = DigestSink();
    sha = sha256.startChunkedConversion(ds);
  }

  SHA256 update(List<int> bytes) {
    sha.add(bytes);
    return this;
  }

  List<int> digest() {
    sha.close();
    return ds.value.bytes;
  }

  @override
  String toString() {
    var bytes = digest();
    return Uint8List.fromList(bytes).toHex();
  }
}
