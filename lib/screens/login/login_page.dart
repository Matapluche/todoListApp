import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:todo_app/screens/home/home_page.dart';
import 'package:todo_app/screens/login/login_bloc.dart';
import '../../utils/alerts.dart';
import '../../utils/validator.dart';
import '../register/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;

  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _loginBloc = LoginBloc();

    Stream showLoadingStream = _loginBloc.showLoadingStream.stream;
    showLoadingStream.listen((value) {
      _showLoading(false);
    });

    Stream showAlertStream = _loginBloc.showAlertStream.stream;
    showAlertStream.listen((value) {
      _showLoading(false);
      successAlert(context, value);
    });

    Stream navigationStream = _loginBloc.navigationStream.stream;
    navigationStream.listen((value) {
      _showLoading(false);
      _navigation(value);
    });
  }



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: Material(
          child: SafeArea(
            child: Scaffold(
                body: GestureDetector(
                  onTap: () {
                    _focusEmail.unfocus();
                    _focusPassword.unfocus();
                  },
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text('Firebase Authentication'),
                    ),
                    body: _showMainContent(),
                  ),
                ),
            ),
          ),
        ),

        bloc: _loginBloc
    );

  }

  Widget _showMainContent(){
    if (!_isLoading) {
      return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
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
            SizedBox(height: 8.0),
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
            SizedBox(height: 24.0),
            _isLoading
                ? CircularProgressIndicator()
                : Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      _focusEmail.unfocus();
                      _focusPassword.unfocus();
                      if (_formKey.currentState!.validate()) {
                        _loginBloc.startSignInUsingEmailPassword(email: _emailTextController.text,
                            password: _passwordTextController.text);
                      }
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 24.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              RegisterPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
    else{
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  void _navigation(String selectedOption){
    switch(selectedOption) {
      case "registerPage": {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RegisterPage()));
      }
      break;
      case "profilePage": {
        Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new HomePage(user: _loginBloc.user!)));
        //Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new ProfilePage(user: _loginBloc.user!)));
      }
      break;
    }
  }

  void _showLoading(bool state) {
    setState(() {
      _isLoading = state;
    });
  }
}
