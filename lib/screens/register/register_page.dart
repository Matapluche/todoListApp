import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:todo_app/screens/register/register_bloc.dart';
import '../../utils/alerts.dart';
import '../../utils/validator.dart';
import '../home/home_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late RegisterBloc _registerBloc;
  final _registerFormKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _registerBloc = RegisterBloc();

    Stream showLoadingStream = _registerBloc.showLoadingStream.stream;
    showLoadingStream.listen((value) {
      _showLoading(value);
    });

    Stream showAlertStream = _registerBloc.showAlertStream.stream;
    showAlertStream.listen((value) {
      _showLoading(false);
      successAlert(context, value);
    });

    Stream navigationStream = _registerBloc.navigationStream.stream;
    navigationStream.listen((value) {
      _showLoading(false);
      _navigation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: Material(
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: _showAppBar() as PreferredSizeWidget?,
              body: _showMainContent(),
            ),
          ),
        ),
        bloc: _registerBloc
    );
  }

  Widget _showAppBar(){
    if(!_isLoading){
      return  AppBar(
          title: Text('Registro')
      );
    }
    else{
      return PreferredSize(
          preferredSize: Size.fromHeight(0), // here the desired height
          child: AppBar(
          )
      );
    }
  }

  Widget _showMainContent(){
    if(!_isLoading){
      return Center(
          child :  Container(
            width: double.infinity,
            margin: EdgeInsets.only(right: 18, left: 18, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _registerFormKey,
                  child: Column(
                    children: <Widget>[
                      Image(image: AssetImage('assets/images/login.png'), height: 100,),
                      SizedBox(height: 30,),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _nameTextController,
                        focusNode: _focusName,
                        validator: (value) => Validator.validateName(
                          name: value,
                        ),
                        decoration: InputDecoration(
                          hintText: "Nombre",
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
                        textInputAction: TextInputAction.next,
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
                      SizedBox(height: 16.0),
                      TextFormField(
                        textInputAction: TextInputAction.done,
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
                      SizedBox(height: 32.0),
                      Row(children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              _fieldsValidation();
                            },
                            child: Text(
                              'Registrarse',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],)
                    ],
                  ),
                )
              ],
            ),
          )
      );
    }
    else{
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  void _fieldsValidation() {
    if (_registerFormKey.currentState!.validate()) {
      _registerBloc.startRegisterUsingEmailPassword(name: _nameTextController.text,
          email: _emailTextController.text, password: _passwordTextController.text);
    }
  }

  void _navigation(){
    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (BuildContext context) => HomePage(user: _registerBloc.user!),),
          (route) => false,
    );
  }

  void _showLoading(bool state) {
    setState(() {
      _isLoading = state;
    });
  }
}
