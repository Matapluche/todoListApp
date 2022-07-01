import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'locator/service_locator.dart';
import 'package:flutter/foundation.dart';

import 'screens/login/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFirebase();
  setupLocator();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
    //  home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: LoginPage(),
    );
  }
}

/// Method that initialize the firebase sdk
Future<void> _initializeFirebase() async {
  await Firebase.initializeApp();

}

