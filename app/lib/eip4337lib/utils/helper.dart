import 'dart:math';

import 'package:http/http.dart';
import 'package:app/web3dart/web3dart.dart';
import 'package:app/web3dart/credentials.dart';

const apiUrl = "https://ropsten.infura.io/v3/754cdf1de04349e1b5687b8a592cb536";

class Web3Helper {
  static Web3Client? _web3;

  static Web3Client web3() {
    if (_web3 == null) {
      var httpClient = Client();
      _web3 = Web3Client(apiUrl, httpClient);
    }
    return _web3!;
  }

  static Wallet createWallet(EthPrivateKey credentials, String password) {
    final rng = Random.secure();
    return Wallet.createNew(credentials, password, rng);
  }

  static EthPrivateKey recoverWallet(String json, String password) {
    Wallet wallet = Wallet.fromJson(json, password);
    return wallet.privateKey;
  }

  // tmp
  static EthPrivateKey generateKey() {
    final rng = Random.secure();
    return EthPrivateKey.createRandom(rng);
  }

  static EthPrivateKey recoverKeys(String privateKey) {
    return EthPrivateKey.fromHex(privateKey);
  }

}