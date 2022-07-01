import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:todo_app/usecases/firebaseauth/register_using_email_password_use_case.dart';
import '../../locator/service_locator.dart';
import '../../usecases/firebaseauth/signin_using_email_password_use_case.dart';

class RegisterBloc extends Bloc {

    final RegisterUsingEmailPasswordUseCase? _registerUsingEmailPasswordUseCase;

    StreamController<String> navigationStream = StreamController<String>();

    RegisterBloc({
        RegisterUsingEmailPasswordUseCase? registerUsingEmailPasswordUseCase,
    }): _registerUsingEmailPasswordUseCase = registerUsingEmailPasswordUseCase ?? locator<RegisterUsingEmailPasswordUseCase>();

   //region

    Future<User?> registerUsingEmailPassword({required String name, required String email,
        required String password}) {
        return _registerUsingEmailPasswordUseCase!.invoke(name: name, email: email, password: password);
    }

    //endregion


    @override
    void dispose() {
        navigationStream.close();
    }

}