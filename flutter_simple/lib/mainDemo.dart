///dart 基础语法测试

void main() {
  A a1 = A("a1");
  var a2 = A("a2");

  print(a1.toString());
  print(a2.hashCode);
  print(a1 == a2);

  print("\n");

  var b1 = new B("b1");
  var b2 = const B("b2");
  print(b1.hashCode);
  print(b2.hashCode);
  print(b1 == b2);
}


class A {
  final String text;

  A(this.text);

  @override
  int get hashCode => super.hashCode;

}

class B {
  final String text;

  const B(this.text);
}

class C {
  String text;

  C(this.text);
}