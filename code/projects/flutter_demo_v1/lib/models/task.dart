enum Priority { low, medium, high }

class Task {
  String? id;
  String subject;
  String content;
  String categories;
  String priority;

  Task({
    this.id,
    required this.subject,
    required this.content,
    required this.categories,
    required this.priority,
  });

  // Convert to Json to send to mockapi.io
  Map<String, dynamic> toJson() {
    return {
      "subject": subject,
      "content": content,
      "categories": categories,
      "priority": priority,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["id"],
      subject: json["subject"],
      content: json["content"],
      categories: json["categories"],
      priority: json["priority"],
    );
  }
}
