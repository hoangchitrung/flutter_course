import 'dart:io';

void main() {
  // ax + b = 0
  /** */
  stdout.write("a = ");
  int a = int.parse(stdin.readLineSync()!);
  stdout.write("b = ");
  int b = int.parse(stdin.readLineSync()!);

  if (a == 0) {
    if (b == 0) {
      print("many roots");
    } else {
      print("equation has no root");
    }
  } else {
    print("x = ${-b / a}");
  }

  // If value is null will print this value
  /**
   * Syntax: name?? = "value" (will print "value" if null)
   */
  String? test1;
  print(test1 ?? "Guest");

  test1 ??= "Guest";
  print(test1);
}
