import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/tasks/task.dart';


class FirestoreRemoteDataSource {

    Future<List<Task>> getTasks(String collectionName) async {
        final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(collectionName).orderBy("date", descending: true).get();
        final List<DocumentSnapshot> docs = querySnapshot.docs;
        final List<Task> taskList = <Task>[];
        docs.forEach((DocumentSnapshot document) {
            taskList.add(Task.fromDocumentSnapshot(document));
        });
        return taskList;
    }

    Future<bool?> createTask(String collectionName, Task task) async {
        await FirebaseFirestore.instance.collection(collectionName).add({
            "title": task.title,
            "description": task.description,
            "translatedTitle": task.translatedTitle,
            "translatedDescription": task.translatedDescription,
            "isCompleted": false,
            "date": DateTime.now()
        }).then((_){
            return true;
        }).catchError((_){
            return false;
        });
    }

    void deleteTask(String collectionName, String documentId){
        final collection = FirebaseFirestore.instance.collection(collectionName);
        collection
            .doc(documentId)
            .delete()
            .then((_) => print('Deleted'))
            .catchError((error) => print('Delete failed: $error'));
    }

    void updateTaskState(String collectionName, String documentId, bool isCompleted){
        var collection = FirebaseFirestore.instance.collection(collectionName);
        collection
            .doc(documentId)
            .update({'isCompleted' : isCompleted})
            .then((_) => print('Updated'))
            .catchError((error) => print('Update Failed: $error'));
    }

}