///dart 基础语法测试

void main() {
//  print(Substract is Function);
//  print(Substract is Add);
  print("main Start");

  var x = makeNum(7);
  print(x(1));
}

typedef int Add(int a, int b);

/// 闭包函数
Function makeNum(num n) {
  return (num i) => n - i;
}

class fun {
  int subtract(int a, int b) => a - b;
}
