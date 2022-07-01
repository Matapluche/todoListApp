import 'package:todo_app/models/tasks/task.dart';
import '../../data/repository/firestore/firestore_repository.dart';
import '../../locator/service_locator.dart';

class CreateTaskUseCase {

    final FirestoreRepository? _firestoreRepository;

    CreateTaskUseCase({
        FirestoreRepository? firestoreRepository
    }): _firestoreRepository = firestoreRepository ?? locator<FirestoreRepository>();

    Future<bool?> invoke(String collectionName, Task task) async {
        return _firestoreRepository!.createTask(collectionName, task);
    }


}