import 'package:todo_app/models/tasks/task.dart';
import '../../data/repository/firestore/firestore_repository.dart';
import '../../locator/service_locator.dart';

class GetTasksUseCase {

    final FirestoreRepository? _firestoreRepository;

    GetTasksUseCase({
        FirestoreRepository? getTasksRepository
    }): _firestoreRepository = getTasksRepository ?? locator<FirestoreRepository>();

    Future<List<Task>> invoke(String collectionName) {
        return _firestoreRepository!.getOperationReasons(collectionName);
    }

}