class Student {
  int? _id;
  String? _name;

  Student(this._id, this._name);

  void display() {
    print("Id: ${this._id} - Name: ${this._name}");
  }

  // Getter Setter
  set name2(String n) => _name = n;
}

class Fraction {
  int? _numerator;
  int? _denominator;

  Fraction(this._numerator, this._denominator);

  String get getFraction {
    return "${this._numerator!} / ${this._denominator!}";
  }

  Fraction add(Fraction otherFraction) {
    int newNumerator =
        (this._numerator! * otherFraction._denominator!) +
        (this._denominator! * otherFraction._numerator!);

    int newDecominator = this._denominator! * otherFraction._denominator!;
    return Fraction(newNumerator, newDecominator);
  }
}

void main() {
  Student s = Student(11, "Hoang Chi Trung");
  // s.display();

  s.name2 = "Test";
  // s.display();
  List<Student> a = [
    Student(9, "A"),
    Student(3, "B"),
    Student(7, "C"),
    Student(4, "D"),
    Student(5, "E"),
  ]; // student arrays

  a.add(Student(6, "F"));
  a.sort((x, y) => x._id! - y._id!);
  for (var s in a) {
    s.display();
  }

  // Fraction
  Fraction f1 = Fraction(1, 2);
  Fraction f2 = Fraction(1, 3);

  Fraction sum = f1.add(f2);

  print("Total: ");
}
