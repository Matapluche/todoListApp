import 'package:todo_app/models/tasks/task.dart';
import '../../../locator/service_locator.dart';
import '../../datasource/firestore/firestore_remote_data_source.dart';

class FirestoreRepository {
    final FirestoreRemoteDataSource? _firestoreRemoteDataSource;

    FirestoreRepository({
        FirestoreRemoteDataSource? getTasksRemoteDataSource
    }): _firestoreRemoteDataSource = getTasksRemoteDataSource ?? locator<FirestoreRemoteDataSource>();

    Future<List<Task>> getOperationReasons(String collectionName) {
        return _firestoreRemoteDataSource!.getTasks(collectionName);
    }

    Future<bool?> createCollection(String collectionName, Map<String, dynamic> task) async  {
        return _firestoreRemoteDataSource!.createCollection(collectionName, task);
    }

}