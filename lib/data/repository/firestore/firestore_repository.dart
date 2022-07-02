import 'package:todo_app/models/tasks/task.dart';
import '../../../locator/service_locator.dart';
import '../../datasource/firestore/firestore_remote_data_source.dart';

class FirestoreRepository {
    final FirestoreRemoteDataSource? _firestoreRemoteDataSource;

    FirestoreRepository({
        FirestoreRemoteDataSource? getTasksRemoteDataSource
    }): _firestoreRemoteDataSource = getTasksRemoteDataSource ?? locator<FirestoreRemoteDataSource>();

    Future<List<Task>> getTasks(String collectionName) {
        return _firestoreRemoteDataSource!.getTasks(collectionName);
    }

    Future<bool?> createTask(String collectionName, Task task) async  {
        return _firestoreRemoteDataSource!.createTask(collectionName, task);
    }

    void deleteTask(String collectionName, String documentId) async  {
        return _firestoreRemoteDataSource!.deleteTask(collectionName, documentId);
    }

    void updateTaskState(String collectionName, String documentId, bool isCompleted) async  {
        return _firestoreRemoteDataSource!.updateTaskState(collectionName, documentId, isCompleted);
    }

}