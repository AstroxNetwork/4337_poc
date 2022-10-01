import 'package:app/web3dart/contracts.dart';
import 'package:app/web3dart/credentials.dart';

const entrypoint = '0xbAecF6408a14C2bbBF62c87C554689E0FFC24C34';
final entryPointAddress = EthereumAddress.fromHex(entrypoint);

void main() async {

  print(entryPointAddress.hexNo0x);
}