import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  static const String collectionName = "tasks";
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  Task({
    this.id = "",
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false,
  });

  // موجه لتحويل البيانات من Firestore إلى كائن Task
  Task.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data["id"] as String? ?? "",
          title: data["title"] as String? ?? "",
          description: data["description"] as String? ?? "",
          dateTime: data['dateTime'] is Timestamp
              ? (data['dateTime'] as Timestamp).toDate()
              : DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
          isDone: data["isDone"] as bool? ?? false,
        );

  // موجه لتحويل كائن Task إلى بيانات لتخزينها في Firestore
  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      'dateTime': Timestamp.fromDate(dateTime),
      "isDone": isDone,
    };
  }
}
