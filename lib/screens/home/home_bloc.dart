import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '../../locator/service_locator.dart';
import '../../usecases/firestore/create_collection_use_case.dart';
import '../../usecases/firestore/get_tasks_use_case.dart';

class HomeBloc extends Bloc {

    final GetTasksUseCase? _getTasksUseCase;
    final CreateCollectionUseCase? _createCollectionUseCase;

    StreamController<String> navigationStream = StreamController<String>();
    StreamController<String> showAlertStream = StreamController<String>();
    StreamController<bool> showLoadingStream = StreamController<bool>();

    User? user;

    HomeBloc({
        GetTasksUseCase? getTasksUseCase,
        CreateCollectionUseCase? createCollectionUseCase
    }): _getTasksUseCase = getTasksUseCase ?? locator<GetTasksUseCase>(),
            _createCollectionUseCase = createCollectionUseCase ?? locator<CreateCollectionUseCase>();

   //region SignInUsingEmailPassword

    Future<bool?> createCollection(String collectionName, Map<String, dynamic> task) async  {
        return _createCollectionUseCase!.invoke(collectionName, task);
    }

    void startCreateCollection(String title, String description){
        final task = <String, dynamic>{
            "title": title,
            "description": description,
            "isCompleted": false,
            "date": DateTime.now()
        };
        showLoadingStream.add(true);
        createCollection(user!.email!, task).then((value)  {
           if (value != null) {

           }
        }).onError((error, stackTrace) {
            showLoadingStream.add(false);
            showAlertStream.add(error.toString());
        });
    }

    //endregion



    @override
    void dispose() {
        navigationStream.close();
        showAlertStream.close();
        showLoadingStream.close();
    }

}