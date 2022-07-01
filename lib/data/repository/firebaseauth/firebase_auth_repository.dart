import 'package:firebase_auth/firebase_auth.dart';
import '../../../locator/service_locator.dart';
import '../../datasource/firebaseauth/firebase_auth_data_source.dart';

class FirebaseAuthRepository {
    final FireBaseAuthDataSource? _fireBaseAuthDataSource;

    FirebaseAuthRepository({
        FireBaseAuthDataSource? fireBaseAuthDataSource
    }): _fireBaseAuthDataSource = fireBaseAuthDataSource ?? locator<FireBaseAuthDataSource>();

    Future<User?> registerUsingEmailPassword({required String name,
        required String email,
        required String password}) {
        return _fireBaseAuthDataSource!.registerUsingEmailPassword(name: name, email: email, password: password);
    }

    Future<User?> signInUsingEmailPassword({
        required String email,
        required String password}) {
        return _fireBaseAuthDataSource!.signInUsingEmailPassword(email: email, password: password);
    }

    Future<User?> refreshUser(User user) {
        return _fireBaseAuthDataSource!.refreshUser(user);
    }

}