enum ItemType { income, expense }

class Item {
  String? id;
  String content;
  DateTime? createdDate = DateTime.now();
  double amount;
  ItemType type;

  Item({
    this.id,
    required this.content,
    this.createdDate,
    required this.amount,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'content': this.content,
      'amount': this.amount,
      'type': this.type.name,
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"],
      content: json["content"],
      amount: (json["amount"] as num).toDouble(),
      type: ItemType.income,
      createdDate: json["createdDate"],
    );
  }
}
