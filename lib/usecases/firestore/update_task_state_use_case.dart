import 'package:todo_app/models/tasks/task.dart';
import '../../data/repository/firestore/firestore_repository.dart';
import '../../locator/service_locator.dart';

class UpdateTaskStateUseCase {

    final FirestoreRepository? _firestoreRepository;

    UpdateTaskStateUseCase({
        FirestoreRepository? getTasksRepository
    }): _firestoreRepository = getTasksRepository ?? locator<FirestoreRepository>();

    void invoke(String collectionName, String documentId, bool isCompleted) {
        return _firestoreRepository!.updateTaskState(collectionName, documentId, isCompleted);
    }

}