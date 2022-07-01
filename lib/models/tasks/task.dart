import 'package:cloud_firestore/cloud_firestore.dart';

class Task {

    final String? documentId;
    final String? title;
    final String? description;
    final String? translatedTitle;
    final String? translatedDescription;
    final bool? isCompleted;
    final DateTime? date;

    Task({
        required this.documentId,
        required this.title,
        required this.description,
        required this.translatedTitle,
        required this.translatedDescription,
        required this.isCompleted,
        required this.date
    });

    factory Task.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
        Map<dynamic, dynamic> data = documentSnapshot.data() as Map<dynamic, dynamic>;
        var id = documentSnapshot.id;
        return Task(
            documentId: id,
            title: data["title"] as String?,
            description: data["description"] as String?,
            translatedTitle: data["translatedTitle"] as String?,
            translatedDescription: data["translatedDescription"] as String?,
            isCompleted: data["isCompleted"]as bool?,
            date: data["date"].toDate(),
        );
    }
}