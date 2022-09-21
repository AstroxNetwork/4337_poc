@TestOn('vm')
import 'dart:io';

import 'package:http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/web3dart/web3dart.dart';

void main() {
  final infuraProjectId = Platform.environment['INFURA_ID'];

  group(
    'integration',
    () {
      late final Web3Client client;

      setUpAll(() {
        client = Web3Client(
          'https://mainnet.infura.io/v3/$infuraProjectId',
          Client(),
        );
      });

      // ignore: unnecessary_lambdas, https://github.com/dart-lang/linter/issues/2670
      tearDownAll(() => client.dispose());

      test('Web3Client.getBlockInformation', () async {
        final blockInfo = await client.getBlockInformation(
          blockNumber: const BlockNum.exact(14074702).toBlockParam(),
        );

        expect(
          blockInfo.timestamp.millisecondsSinceEpoch == 1643113026000,
          isTrue,
        );
        expect(
          blockInfo.timestamp.isUtc == true,
          isTrue,
        );
      });
    },
    skip: infuraProjectId == null || infuraProjectId.length < 32
        ? 'Tests require the INFURA_ID environment variable'
        : null,
  );
}
