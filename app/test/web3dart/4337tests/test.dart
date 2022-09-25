class A {
  String a;
  int b;
  A(this.a, this.b);
}

void main() {
  var a = A("aaa", 111);
  var b = a;
  b.b = 222;
  print('${a.a}, ${a.b}');
}