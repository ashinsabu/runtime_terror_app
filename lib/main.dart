import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:runtime_terror_app/screens/loginPage.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginPage(),
    );
  }
}

