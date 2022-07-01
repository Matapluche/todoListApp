import 'package:todo_app/models/tasks/task.dart';
import '../../data/repository/firestore/firestore_repository.dart';
import '../../locator/service_locator.dart';

class DeleteTasksUseCase {

    final FirestoreRepository? _firestoreRepository;

    DeleteTasksUseCase({
        FirestoreRepository? getTasksRepository
    }): _firestoreRepository = getTasksRepository ?? locator<FirestoreRepository>();

    void invoke(String collectionName, String documentId) {
        return _firestoreRepository!.deleteTask(collectionName, documentId);
    }

}