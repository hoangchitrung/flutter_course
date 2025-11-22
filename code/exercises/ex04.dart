import 'dart:io';

abstract class Product {
  int id;
  String name;
  double price;

  Product(this.id, this.name, this.price);

  void display(); // abstract method
}

class Book extends Product {
  int pageNumber;

  Book(int id, String name, double price, this.pageNumber)
    : super(id, name, price);

  @override
  void display() {
    print("Book - ID: $id, Name: $name, Price: $price, Pages: $pageNumber");
  }
}

class Disc extends Product {
  double duration;

  Disc(int id, String name, double price, this.duration)
    : super(id, name, price);

  @override
  void display() {
    print("Disc - ID: $id, Name: $name, Price: $price, Duration: $duration");
  }
}

class ProductManager {
  List<Product> products = [];

  void addProduct() {
    print("1. Book");
    print("2. Disc");
    stdout.write("What product would you like to add: ");
    int input = int.parse(stdin.readLineSync()!);
    switch (input) {
      case 1:
        stdout.write("Enter book id: ");
        int bookId = int.parse(stdin.readLineSync()!);
        stdout.write("Enter book name: ");
        String bookName = stdin.readLineSync()!;
        stdout.write("Enter book price: ");
        double bookPrice = double.parse(stdin.readLineSync()!);
        stdout.write("Enter book pages (50 - 200): ");
        int bookPages = int.parse(stdin.readLineSync()!);
        products.add(Book(bookId, bookName, bookPrice, bookPages));
        break;
      case 2:
        stdout.write("Enter disc id: ");
        int discId = int.parse(stdin.readLineSync()!);
        stdout.write("Enter disc name: ");
        String discName = stdin.readLineSync()!;
        stdout.write("Enter disc price: ");
        double discPrice = double.parse(stdin.readLineSync()!);
        stdout.write("Enter disc durations: ");
        double discDurations = double.parse(stdin.readLineSync()!);
        products.add(Disc(discId, discName, discPrice, discDurations));
        break;
      default:
        print("Invalid option.");
    }
  }

  void removeProduct() {
    stdout.write("Enter product id: ");
    int id = int.parse(stdin.readLineSync()!);
    products.removeWhere((p) => p.id == id);
    print("Removed product with id: $id");
  }

  void displayProducts() {
    if (products.isEmpty) {
      print("No products to display.");
      return;
    }
    for (var p in products) {
      p.display();
    }
  }

  void searchProduct() {
    stdout.write("Enter product id: ");
    int id = int.parse(stdin.readLineSync()!);
    var found = products.where((p) => p.id == id);
    if (found.isEmpty) {
      print("Product doesn't exist");
    } else {
      for (var p in found) {
        p.display();
      }
    }
  }

  void sortProducts() {
    products.sort((a, b) => b.price.compareTo(a.price));
    print("Sorted products by price (descending):");
    displayProducts();
  }
}

void main() {
  ProductManager manager = ProductManager();
  while (true) {
    print("\n1. Add Product");
    print("2. Remove Product");
    print("3. Display products");
    print("4. Search product");
    print("5. Sort products by price (descending)");
    print("0. Exit");
    stdout.write("Options: ");
    int input = int.parse(stdin.readLineSync()!);
    switch (input) {
      case 1:
        manager.addProduct();
        break;
      case 2:
        manager.removeProduct();
        break;
      case 3:
        manager.displayProducts();
        break;
      case 4:
        manager.searchProduct();
        break;
      case 5:
        manager.sortProducts();
        break;
      case 0:
        return;
      default:
        print("Invalid option.");
    }
  }
}
