import 'package:cloud_firestore/cloud_firestore.dart';


class Task {

    final String title;
    final String? description;
    final bool? isCompleted;
    final DateTime? date;

    Task({
        required this.title,
        required this.description,
        required this.isCompleted,
        required this.date
    });

    factory Task.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
        Map<dynamic, dynamic> data = documentSnapshot.data() as Map<dynamic, dynamic>;
        return Task(
            title: data["title"] as String,
            description: data["description"] as String?,
            isCompleted: data["isCompleted"]as bool?,
            date: data["date"]as DateTime?,
        );
    }
}