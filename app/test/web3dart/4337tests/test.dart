class A {
  String a;
  int b;
  A(this.a, this.b);
}

void main() {
  // var a = A("aaa", 111);
  // var b = a;
  // b.b = 222;
  // print('${a.a}, ${a.b}');
  test();
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