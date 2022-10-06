import 'package:app/eip4337lib/utils/helper.dart';
import 'package:app/web3dart/credentials.dart';

class A {
  String a;
  int b;
  A(this.a, this.b);
}

void main() async {
  // var a = A("aaa", 111);
  // var b = a;
  // b.b = 222;
  // print('${a.a}, ${a.b}');
  // test();
  final contract = EthereumAddress.fromHex("0xeef5ad6553c72a7812cc522bddcc628503092127");
  final code = await Web3Helper.web3().getCode(contract);
  print(code.isNotEmpty);
}

Future<void> test() async {
  var futureDelayed = Future.delayed(Duration(seconds: 2), () {
    print("Future.delayed");
    return 2;
  });
  // Future(() {
  //   print("future");
  // }).then((value) => print("123"));

  print("test");
}