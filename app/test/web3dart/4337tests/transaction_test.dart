import 'abi.dart';
import 'package:app/web3dart/web3dart.dart';
import 'package:app/web3dart/contracts.dart';
import 'package:app/web3dart/crypto/formatting.dart';

const entrypoint = '0xbAecF6408a14C2bbBF62c87C554689E0FFC24C34';
final entryPointAddress = EthereumAddress.fromHex(entrypoint);
const wethContract = '0xec2a384Fa762C96140c817079768a1cfd0e908EA';
final wethContractAddress = EthereumAddress.fromHex(wethContract);
const wethPaymaster = '0xc299849c75a38fC9c91A7254d0F51A1a385EEb7a';
final wethPaymasterAddress = EthereumAddress.fromHex(wethPaymaster);

void main() async {
  print(execFromEntryPoint.encodeName());
  // for (final func in entryPointABI.functions) {
  //   print(func.encodeName());
  // }

  final construct = soulWalletABI.functions.singleWhere((f) => f.isConstructor);
  print(construct.encodeName());
  final encoded = bytesToHex(construct.encodeCall([entryPointAddress, entryPointAddress, wethContractAddress, wethPaymasterAddress]), include0x: false);
  print(encoded);

}