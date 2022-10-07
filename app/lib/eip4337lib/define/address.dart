import 'package:app/web3dart/credentials.dart';

// class Ropsten {
//   static final chainId = BigInt.from(3);
//   static const entryPoint = "0xbAecF6408a14C2bbBF62c87C554689E0FFC24C34";
//   static final entryPointAddress = EthereumAddress.fromHex(entryPoint);
//   static const paymaster = "0xc299849c75a38fC9c91A7254d0F51A1a385EEb7a";
//   static final paymasterAddress = EthereumAddress.fromHex(paymaster);
//   static const weth = "0xec2a384Fa762C96140c817079768a1cfd0e908EA";
//   static final wethAddress = EthereumAddress.fromHex(weth);
// }

class Goerli {
  static final chainId = BigInt.from(5);
  static const entryPoint = "0x516638fcc2De106C325369187b86747fB29EbF32";
  static final entryPointAddress = EthereumAddress.fromHex(entryPoint);
  static const paymaster = "0x6cfE69b93B91dBfF4d2ea04fFd35dcc06490be4D";
  static final paymasterAddress = EthereumAddress.fromHex(paymaster);
  static const weth = "0x2787015262404f11d7B6920C7eB46e25595e2Bf5";
  static final wethAddress = EthereumAddress.fromHex(weth);

  static final zeroAddress =
      EthereumAddress.fromHex("0x0000000000000000000000000000000000000000");
  static final multiplier = BigInt.from(3);
  static final priorityFee = BigInt.from(10).pow(10);
}
