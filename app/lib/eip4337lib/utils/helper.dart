import 'dart:math';

import 'package:http/http.dart';
import 'package:app/web3dart/web3dart.dart';
import 'package:app/web3dart/credentials.dart';

const apiUrl = "https://goerli.infura.io/v3/754cdf1de04349e1b5687b8a592cb536";

class Web3Helper {
  static final Web3Client client = Web3Client(apiUrl, Client());

  static Wallet createWallet(EthPrivateKey credentials, String password) {
    final rng = Random.secure();
    return Wallet.createNew(credentials, password, rng);
  }

  static EthPrivateKey recoverWallet(String json, String password) {
    Wallet wallet = Wallet.fromJson(json, password);
    return wallet.privateKey;
  }

  static EthPrivateKey generateKey() {
    final rng = Random.secure();
    return EthPrivateKey.createRandom(rng);
  }

  static EthPrivateKey recoverKeys(String privateKey) {
    return EthPrivateKey.fromHex(privateKey);
  }
}
