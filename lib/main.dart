import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runtime_terror_app/screens/loginPage.dart';
import 'package:runtime_terror_app/screens/pharmacistHome.dart';
import 'package:runtime_terror_app/screens/supplyNodeHomePage.dart';
import 'package:runtime_terror_app/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.read<AuthenticationService>().authStateChanges,
            initialData: null)
      ],
      child: MaterialApp(
        title: 'App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
class checker extends StatelessWidget {
  final User? firebaseUser;
  checker({Key? key, @required this.firebaseUser}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(firebaseUser?.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasError){
            return Text("Error: ${snapshot.error}");
          }
          switch(snapshot.connectionState){
            case ConnectionState.waiting: return Text("Loading...");
            default:
              return checkrole(snapshot.data as DocumentSnapshot);
          }
        },
      ),
    );
  }
  Widget checkrole(DocumentSnapshot snapshot){
    if(snapshot['role'] == 'supply')
      return home2();
    else if(snapshot['role'] == 'pharm')
      return home1();
    else return loginPage();
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser =  context.watch<User?>();
    if(firebaseUser != null){
      return checker(firebaseUser: firebaseUser,);
      // return home1();
    }
    return loginPage();
  }
}

