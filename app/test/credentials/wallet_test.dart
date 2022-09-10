import 'dart:convert';

import 'package:app/web3dart/credentials/wallet.dart';
import 'package:app/web3dart/utils/formatting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/web3dart/credentials.dart';
import 'package:app/web3dart/crypto.dart';
import 'package:agent_dart/utils/extension.dart';

import 'example_keystores.dart' as data;

void main() {
  final wallets = json.decode(data.content) as Map;

  wallets.forEach((dynamic testName, dynamic content) {
    test(
      'unlocks wallet $testName',
      () async {
        final password = content['password'] as String;
        final privateKey = content['priv'] as String;
        // final wallet = Wallet.create(privateKey.toU8a());
        // final str = await wallet.toJson(password);

        // print(str);

        final walletData = content['json'] as Map;

        final wallet = await Wallet.fromJson(json.encode(walletData), password);
        expect(bytesToHex(wallet.privateKey.privateKey), privateKey);

        final encodedWallet = json.decode(await wallet.toJson(password)) as Map;

        // expect(
        //   encodedWallet['crypto']['ciphertext'],
        //   walletData['crypto']['ciphertext'],
        // );
      },
      tags: 'expensive',
    );
  });
}
