import 'dart:math'; //used for the random number generator

import 'package:agent_dart/utils/extension.dart';
import 'package:web3dart/web3dart.dart';

void main() async {
  var rng = Random.secure();
  EthPrivateKey credentials = EthPrivateKey.createRandom(rng);

  // var address = await credentials.extractAddress();
  print(credentials.privateKey.toHex());
  print(credentials.address);

  Wallet wallet = Wallet.createNew(credentials, "password", rng);
  print(wallet.toJson());
  var content = wallet.toJson();

  Wallet wallet2 = Wallet.fromJson(content, "password");
  Credentials unlocked = wallet.privateKey;
  var address = await unlocked.extractAddress();
  print(address);
}