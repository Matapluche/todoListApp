import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '../../constants/constants.dart';
import '../../locator/service_locator.dart';
import '../../usecases/firebaseauth/signin_using_email_password_use_case.dart';
import '../../utils/connectivity_validator.dart';

class LoginBloc extends Bloc {

    final SignInUsingEmailPasswordUseCase? _signInUsingEmailPasswordUseCase;
    final ConnectivityValidator? _connectivityValidator;

    StreamController<String> navigationStream = StreamController<String>();
    StreamController<String> showAlertStream = StreamController<String>();
    StreamController<bool> showLoadingStream = StreamController<bool>();

    User? user;

    LoginBloc({
        SignInUsingEmailPasswordUseCase? signInUsingEmailPasswordUseCase,
        ConnectivityValidator? connectivityValidator
    }): _signInUsingEmailPasswordUseCase = signInUsingEmailPasswordUseCase ?? locator<SignInUsingEmailPasswordUseCase>(),
            _connectivityValidator = connectivityValidator ?? locator<ConnectivityValidator>();

   //region SignInUsingEmailPassword

    Future<User?> _signInUsingEmailPassword({required String email,
        required String password}) async {
        return _signInUsingEmailPasswordUseCase!.invoke(email: email, password: password);
    }

    void startSignInUsingEmailPassword({required String email,
        required String password}) async{
        bool result = await _connectivityValidator!.checkInternetConnection();
        if(result){
            showLoadingStream.add(true);
            _signInUsingEmailPassword(email: email, password: password).then((value)  {
                user = value;
                navigationStream.add("homePage");
            }).onError((error, stackTrace) {
                showLoadingStream.add(false);
                showAlertStream.add(error.toString());
            });
        }
        else{
            showAlertStream.add(noInternetAvailableMessage);
        }
    }

    //endregion

    @override
    void dispose() {
        navigationStream.close();
        showAlertStream.close();
        showLoadingStream.close();
    }

}