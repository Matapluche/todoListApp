import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/tasks/task.dart';


class FirestoreRemoteDataSource {

    Future<List<Task>> getTasks(String collectionName) async {
        final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(collectionName).get();
        final List<DocumentSnapshot> docs = querySnapshot.docs;
        final List<Task> operationReasonsList = <Task>[];
        docs.forEach((DocumentSnapshot document) {
            operationReasonsList.add(Task.fromDocumentSnapshot(document));
        });
        return operationReasonsList;
    }

    Future<bool?> createCollection(String collectionName, Map<String, dynamic> task) async {
        await FirebaseFirestore.instance.collection(collectionName).add({
            "key":task
        }).then((_){
            print("collection created");
            return true;
        }).catchError((_){
            print("an error occured");
            return false;
        });
    }

}