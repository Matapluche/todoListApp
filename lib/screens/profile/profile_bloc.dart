import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '../../locator/service_locator.dart';
import '../../usecases/firebaseauth/refresh_user_use_case.dart';
import '../../usecases/firebaseauth/signin_using_email_password_use_case.dart';

class ProfileBloc extends Bloc {

    final RefreshUserUseCase? _refreshUserUseCase;

    StreamController<String> navigationStream = StreamController<String>();

    ProfileBloc({
        RefreshUserUseCase? refreshUserUseCase,
    }): _refreshUserUseCase = refreshUserUseCase ?? locator<RefreshUserUseCase>();

   //region RefreshUser

    Future<User?> refreshUser(User user) {
        return _refreshUserUseCase!.invoke(user);
    }

    //endregion


    @override
    void dispose() {
        navigationStream.close();
    }

}