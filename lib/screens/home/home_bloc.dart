import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:translator/translator.dart';
import '../../constants/constants.dart';
import '../../locator/service_locator.dart';
import '../../models/tasks/task.dart';
import '../../usecases/firestore/create_task_use_case.dart';
import '../../usecases/firestore/delete_task_use_case.dart';
import '../../usecases/firestore/get_tasks_use_case.dart';
import '../../usecases/firestore/update_task_state_use_case.dart';
import '../../utils/connectivity_validator.dart';

class HomeBloc extends Bloc {

    final GetTasksUseCase? _getTasksUseCase;
    final CreateTaskUseCase? _createCollectionUseCase;
    final DeleteTasksUseCase? _deleteTasksUseCase;
    final UpdateTaskStateUseCase? _updateTaskStateUseCase;
    final ConnectivityValidator? _connectivityValidator;

    StreamController<String> showAlertStream = StreamController<String>();
    StreamController<bool> reloadStream = StreamController<bool>();

    final translator = GoogleTranslator();
    Translation? translatedTitle;
    Translation? translatedDescription;
    User? user;

    HomeBloc({
        GetTasksUseCase? getTasksUseCase,
        CreateTaskUseCase? createCollectionUseCase,
        DeleteTasksUseCase? deleteTasksUseCase,
        UpdateTaskStateUseCase? updateTaskStateUseCase,
        ConnectivityValidator? connectivityValidator
    }): _getTasksUseCase = getTasksUseCase ?? locator<GetTasksUseCase>(),
            _createCollectionUseCase = createCollectionUseCase ?? locator<CreateTaskUseCase>(),
            _deleteTasksUseCase = deleteTasksUseCase ?? locator<DeleteTasksUseCase>(),
            _updateTaskStateUseCase = updateTaskStateUseCase ?? locator<UpdateTaskStateUseCase>(),
            _connectivityValidator = connectivityValidator ?? locator<ConnectivityValidator>();

    //region GetTasks

    Future<List<Task>> getTasks() {
        return _getTasksUseCase!.invoke(user!.email!);
    }

    //endregion

   //region CreateNewTask

    Future<bool?> _createNewTask(String collectionName, Task task) async  {
        return _createCollectionUseCase!.invoke(collectionName, task);
    }

    void startCreateNewTask(String title, String description) async{
        final task = Task(
            documentId: "",
            title: title,
            description: description,
            translatedTitle: translatedTitle.toString(),
            translatedDescription: translatedDescription.toString(),
            isCompleted: false,
            date: DateTime.now()
        );
        _createNewTask(user!.email!, task).then((value)  {
            reloadStream.add(true);
        }).onError((error, stackTrace) {
            showAlertStream.add(error.toString());
        });
    }

    //endregion

    //region deleteTask

    void deleteTask(String documentId) async  {
        return _deleteTasksUseCase!.invoke(user!.email!, documentId);
    }

    //endregion

    //region updateTask

    void updateTaskState(String documentId, bool isCompleted) async  {
        return _updateTaskStateUseCase!.invoke(user!.email!, documentId, isCompleted);
    }

    //endregion

    //region Translate

    void translate(String title, String description) async {
        bool result = await _connectivityValidator!.checkInternetConnection();
        if(result){
            translatedDescription = await translator.translate(description, from: 'es', to: 'en');
            translatedTitle = await translator.translate(title, from: 'es', to: 'en');
            startCreateNewTask(title, description);
        }
        else{
            showAlertStream.add(noInternetAvailableMessage);
        }
    }

    //endregion

    @override
    void dispose() {
        showAlertStream.close();
        reloadStream.close();
    }

}