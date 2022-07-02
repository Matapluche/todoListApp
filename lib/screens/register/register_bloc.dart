import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:todo_app/usecases/firebaseauth/register_using_email_password_use_case.dart';
import '../../locator/service_locator.dart';

class RegisterBloc extends Bloc {

    final RegisterUsingEmailPasswordUseCase? _registerUsingEmailPasswordUseCase;

    StreamController<bool> navigationStream = StreamController<bool>();
    StreamController<String> showAlertStream = StreamController<String>();
    StreamController<bool> showLoadingStream = StreamController<bool>();

    User? user;

    RegisterBloc({
        RegisterUsingEmailPasswordUseCase? registerUsingEmailPasswordUseCase,
    }): _registerUsingEmailPasswordUseCase = registerUsingEmailPasswordUseCase ?? locator<RegisterUsingEmailPasswordUseCase>();

   //region

    Future<User?> _registerUsingEmailPassword({required String name, required String email,
        required String password}) {
        return _registerUsingEmailPasswordUseCase!.invoke(name: name, email: email, password: password);
    }

    void startRegisterUsingEmailPassword({required String name, required String email,
        required String password}){
        showLoadingStream.add(true);
        _registerUsingEmailPassword(name: name, email: email, password: password).then((value)  {
            user = value;
            _onStartRegisterUsingEmailPasswordSuccess();
        }).onError((error, stackTrace) {
            showAlertStream.add(error.toString());
        });
    }

    void _onStartRegisterUsingEmailPasswordSuccess(){
        if (user != null) {
           navigationStream.add(true);
        }
        else{
            showAlertStream.add("Ha ocurrido un problema, por favor intente de nuevo.");
        }
    }

    //endregion

    @override
    void dispose() {
        navigationStream.close();
        showLoadingStream.close();
        showAlertStream.close();
    }

}