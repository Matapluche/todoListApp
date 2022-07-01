import 'package:firebase_auth/firebase_auth.dart';
import '../../data/repository/firebaseauth/firebase_auth_repository.dart';
import '../../locator/service_locator.dart';

class RefreshUserUseCase {

    final FirebaseAuthRepository? _firebaseAuthRepository;

    RefreshUserUseCase({
        FirebaseAuthRepository? firebaseAuthRepository
    }): _firebaseAuthRepository = firebaseAuthRepository ?? locator<FirebaseAuthRepository>();

    Future<User?> invoke(User user) {
        return _firebaseAuthRepository!.refreshUser(user);
    }

}