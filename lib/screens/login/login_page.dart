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
      _showLoading(value);
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
              resizeToAvoidBottomInset: false,
              body: GestureDetector(
                  onTap: () {
                    _focusEmail.unfocus();
                    _focusPassword.unfocus();
                  },
                  child: Scaffold(
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
      return Center(
        child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(right: 18, left: 18, bottom: 10),
            child: Column(
              children: [
                Expanded(child: SizedBox()),
                Image(image: AssetImage('assets/images/login.png'), height: 100,),
                SizedBox(height: 30,),
                Form(
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
                          hintText: "Correo electrónico",
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
                          hintText: "Contraseña",
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
                                'Ingresar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(width: 24.0),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                //_loginBloc.similarity();
                                _navigation("registerPage");
                              },
                              child: Text(
                                'Registro',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(child: SizedBox()),
              ],
            )
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
