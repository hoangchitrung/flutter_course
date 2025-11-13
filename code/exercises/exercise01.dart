import 'dart:io';
import 'dart:math';

int randomInteger() {
  return Random().nextInt(100);
}

void main() {
  int randomNumber = randomInteger();
  int yourGuest;
  do {
    stdout.write("Enter your number: ");
    yourGuest = int.parse(stdin.readLineSync()!);
    print("My Guess: $yourGuest");
    print("Random: $randomNumber");
    if (yourGuest < randomNumber) {
      print("Your guess is too low");
    } else if (yourGuest > randomNumber) {
      print("Your guess is too high");
    } else if (yourGuest == randomNumber) {
      print("Yout guess is correct");
    }
  } while (yourGuest != randomNumber);
}
