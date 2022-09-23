import 'package:agent_dart/utils/extension.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:app/web3dart/json_rpc.dart';

final apiUrl = "https://goerli.infura.io/v3/754cdf1de04349e1b5687b8a592cb536";
final uri = Uri.parse('url');

void main() async {
  var httpClient = Client();
  var ethClient = Web3Client(apiUrl, httpClient);
  // var credentials = ethClient.credentialsFromPrivateKey("0x...");
  int block = await ethClient.getBlockNumber();
  print(block);
}