import 'dart:math';

import 'package:http/http.dart';
import 'package:app/web3dart/web3dart.dart';
import 'package:app/web3dart/credentials.dart';

const apiUrl = "https://ropsten.infura.io/v3/754cdf1de04349e1b5687b8a592cb536";

class Web3Helper {
  static Web3Client? _web3;
  static EthPrivateKey? _cred;

  static Web3Client web3() {
    if (_web3 == null) {
      var httpClient = Client();
      _web3 = Web3Client(apiUrl, httpClient);
    }
    return _web3!;
  }

  static EthPrivateKey credentials() {
    if (_cred == null) {
      throw Exception("credentials empty");
    }
    return _cred!;
  }

  static String createWallet(String password) {
    var rng = Random.secure();
    EthPrivateKey credentials = EthPrivateKey.createRandom(rng);
    Wallet wallet = Wallet.createNew(credentials, password, rng);
    return wallet.toJson();
  }

  static void recoverWallet(String json, String password) {
    Wallet wallet = Wallet.fromJson(json, password);
    _cred = wallet.privateKey;
  }

  static EthPrivateKey recoverKeys(String privateKey) {
    return EthPrivateKey.fromHex(privateKey);
  }

}