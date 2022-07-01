import 'package:firebase_auth/firebase_auth.dart';
import '../../data/repository/firebaseauth/firebase_auth_repository.dart';
import '../../locator/service_locator.dart';

class RegisterUsingEmailPasswordUseCase {

    final FirebaseAuthRepository? _firebaseAuthRepository;

    RegisterUsingEmailPasswordUseCase({
        FirebaseAuthRepository? firebaseAuthRepository
    }): _firebaseAuthRepository = firebaseAuthRepository ?? locator<FirebaseAuthRepository>();

    Future<User?> invoke({required String name,
        required String email,
        required String password}) {
        return _firebaseAuthRepository!.registerUsingEmailPassword(name: name, email: email, password: password);
    }

}