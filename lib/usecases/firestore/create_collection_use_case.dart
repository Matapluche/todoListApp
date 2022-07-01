import 'package:todo_app/models/tasks/task.dart';
import '../../data/repository/firestore/firestore_repository.dart';
import '../../locator/service_locator.dart';

class CreateCollectionUseCase {

    final FirestoreRepository? _firestoreRepository;

    CreateCollectionUseCase({
        FirestoreRepository? firestoreRepository
    }): _firestoreRepository = firestoreRepository ?? locator<FirestoreRepository>();

    Future<bool?> invoke(String collectionName, Map<String, dynamic> task) async {
        return _firestoreRepository!.createCollection(collectionName, task);
    }


}