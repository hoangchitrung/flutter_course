import 'dart:io';
import 'dart:math';

int add(int num1, int num2) {
  return num1 + num2;
}

// add defaul value for params
int add2(int num1, [int num2 = 20]) {
  return num1 + num2;
}

// Null pointer => Null safety
int add3({int? num1, int? num2}) {
  return num1! + num2!;
}

// Anonymous function
var sub = (int x, int y) {
  return x - y;
};

// arrow function
int mul(x, y) => x * y;

// exercise
double f([int? n, double? x]) {
  if (n == null) {
    // Input n
    stdout.write("Nhập bậc N: ");
    n = int.parse(stdin.readLineSync()!);
  }

  if (x == null) {
    // Input x
    stdout.write("Nhập x: ");
    x = double.parse(stdin.readLineSync()!);
  }

  // Input n: a0 -> an
  double v = 0;
  for (int i = 0; i <= n!; i++) {
    // nhap a
    double a = double.parse(stdin.readLineSync()!);
    v += a * pow(x, i);
  }
  return v;
}

void main() {
  // print(add(10, 15));
  // print(add2(10, 15));
  // print(add3(num2: 10, num1: 15));
  // print(mul(10, 15));

  // Exercise
  print("case 1");
  double v1 = f();

  print("case 2:");
  double v2 = f(10, 15);
}
