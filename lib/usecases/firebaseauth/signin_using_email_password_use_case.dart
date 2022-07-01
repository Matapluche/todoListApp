import 'package:firebase_auth/firebase_auth.dart';
import '../../data/repository/firebaseauth/firebase_auth_repository.dart';
import '../../locator/service_locator.dart';

class SignInUsingEmailPasswordUseCase {

    final FirebaseAuthRepository? _firebaseAuthRepository;

    SignInUsingEmailPasswordUseCase({
        FirebaseAuthRepository? firebaseAuthRepository
    }): _firebaseAuthRepository = firebaseAuthRepository ?? locator<FirebaseAuthRepository>();

    Future<User?> invoke({required String email,
        required String password}) {
        return _firebaseAuthRepository!.signInUsingEmailPassword(email: email, password: password);
    }

}