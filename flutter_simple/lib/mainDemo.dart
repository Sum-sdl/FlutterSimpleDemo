///dart 基础语法测试

void main() {
  print("main Start");

  SortedCollection coll = SortedCollection(sort);
  coll._add = sort;

  print(coll.compare is Function);
  coll.compare("a", "b");
  coll._add(1, 2);

  print("main end");
}

typedef int _Add(int a, int b);

class SortedCollection {
  Function compare;
  _Add _add;

  SortedCollection(int f(Object a, Object b)) {
    compare = f;
  }
}

// Initial, broken implementation.
int sort(Object a, Object b) {
  print(a);
  print(b);
  return 0;
}
