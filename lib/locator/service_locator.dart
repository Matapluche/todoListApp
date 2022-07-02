import 'package:get_it/get_it.dart';
import 'package:todo_app/data/datasource/firebaseauth/firebase_auth_data_source.dart';
import 'package:todo_app/data/repository/firebaseauth/firebase_auth_repository.dart';
import 'package:todo_app/data/repository/firestore/firestore_repository.dart';
import 'package:todo_app/usecases/firestore/delete_task_use_case.dart';

import '../data/datasource/firestore/firestore_remote_data_source.dart';
import '../usecases/firebaseauth/refresh_user_use_case.dart';
import '../usecases/firebaseauth/register_using_email_password_use_case.dart';
import '../usecases/firebaseauth/signin_using_email_password_use_case.dart';
import '../usecases/firestore/create_task_use_case.dart';
import '../usecases/firestore/get_tasks_use_case.dart';
import '../usecases/firestore/update_task_state_use_case.dart';

final GetIt locator = GetIt.instance..allowReassignment = true;
void setupLocator() {

    ///Data sources
    locator.registerLazySingleton<FirestoreRemoteDataSource>(() => FirestoreRemoteDataSource());
    locator.registerLazySingleton<FireBaseAuthDataSource>(() => FireBaseAuthDataSource());

    ///Repositories
    locator.registerLazySingleton<FirebaseAuthRepository>(() => FirebaseAuthRepository());
    locator.registerLazySingleton<FirestoreRepository>(() => FirestoreRepository());

    ///Uses cases
    locator.registerLazySingleton<GetTasksUseCase>(() => GetTasksUseCase());
    locator.registerLazySingleton<RefreshUserUseCase>(() => RefreshUserUseCase());
    locator.registerLazySingleton<RegisterUsingEmailPasswordUseCase>(() => RegisterUsingEmailPasswordUseCase());
    locator.registerLazySingleton<SignInUsingEmailPasswordUseCase>(() => SignInUsingEmailPasswordUseCase());
    locator.registerLazySingleton<CreateTaskUseCase>(() => CreateTaskUseCase());
    locator.registerLazySingleton<DeleteTasksUseCase>(() => DeleteTasksUseCase());
    locator.registerLazySingleton<UpdateTaskStateUseCase>(() => UpdateTaskStateUseCase());


}