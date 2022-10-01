
import 'package:app/web3dart/credentials.dart';

class Ropsten {
  static final chainId = BigInt.from(3);
  static const entryPoint = "0xbAecF6408a14C2bbBF62c87C554689E0FFC24C34";
  static final entryPointAddress = EthereumAddress.fromHex(entryPoint);
  static const paymaster = "0xc299849c75a38fC9c91A7254d0F51A1a385EEb7a";
  static final paymasterAddress = EthereumAddress.fromHex(paymaster);
  static const weth = "0xec2a384Fa762C96140c817079768a1cfd0e908EA";
  static final wethAddress = EthereumAddress.fromHex(weth);
}