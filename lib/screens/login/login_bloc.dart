import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '../../locator/service_locator.dart';
import '../../models/tasks/task.dart';
import '../../usecases/firebaseauth/signin_using_email_password_use_case.dart';
import '../../usecases/firestore/create_collection_use_case.dart';

class LoginBloc extends Bloc {

    final SignInUsingEmailPasswordUseCase? _signInUsingEmailPasswordUseCase;
    final CreateCollectionUseCase? _createCollectionUseCase;

    StreamController<String> navigationStream = StreamController<String>();
    StreamController<String> showAlertStream = StreamController<String>();
    StreamController<bool> showLoadingStream = StreamController<bool>();

    User? user;

    LoginBloc({
        SignInUsingEmailPasswordUseCase? signInUsingEmailPasswordUseCase,
        CreateCollectionUseCase? createCollectionUseCase
    }): _signInUsingEmailPasswordUseCase = signInUsingEmailPasswordUseCase ?? locator<SignInUsingEmailPasswordUseCase>(),
            _createCollectionUseCase = createCollectionUseCase ?? locator<CreateCollectionUseCase>();

   //region SignInUsingEmailPassword

    Future<User?> signInUsingEmailPassword({required String email,
        required String password}) async {
        return _signInUsingEmailPasswordUseCase!.invoke(email: email, password: password);
    }

    void startSignInUsingEmailPassword({required String email,
        required String password}){
        showLoadingStream.add(true);
        signInUsingEmailPassword(email: email, password: password).then((value)  {
            user = value;
            navigationStream.add("profilePage");
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