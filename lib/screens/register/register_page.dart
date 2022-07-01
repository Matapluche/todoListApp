import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:todo_app/screens/register/register_bloc.dart';

import '../../utils/validator.dart';
import '../profile/profile_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterBloc _registerBloc = RegisterBloc();
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: Material(
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text('Profile'),
              ),
              body: GestureDetector(
                onTap: () {
                  _focusName.unfocus();
                  _focusEmail.unfocus();
                  _focusPassword.unfocus();
                },
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('Register'),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                            key: _registerFormKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: _nameTextController,
                                  focusNode: _focusName,
                                  validator: (value) => Validator.validateName(
                                    name: value,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Name",
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                  controller: _emailTextController,
                                  focusNode: _focusEmail,
                                  validator: (value) => Validator.validateEmail(
                                    email: value,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                  controller: _passwordTextController,
                                  focusNode: _focusPassword,
                                  obscureText: true,
                                  validator: (value) => Validator.validatePassword(
                                    password: value,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 32.0),
                                _isProcessing
                                    ? CircularProgressIndicator()
                                    : Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            _isProcessing = true;
                                          });

                                          if (_registerFormKey.currentState!
                                              .validate()) {
                                            User? user = await _registerBloc
                                                .registerUsingEmailPassword(
                                              name: _nameTextController.text,
                                              email: _emailTextController.text,
                                              password:
                                              _passwordTextController.text,
                                            );

                                            setState(() {
                                              _isProcessing = false;
                                            });

                                            if (user != null) {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilePage(user: user),
                                                ),
                                                ModalRoute.withName('/'),
                                              );
                                            }
                                          }
                                        },
                                        child: Text(
                                          'Sign up',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        bloc: _registerBloc
    );

  }
}
