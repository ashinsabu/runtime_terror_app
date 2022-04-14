import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runtime_terror_app/services/authentication_service.dart';
import 'package:runtime_terror_app/theme.dart';

class home1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pharmacist Services"),
        backgroundColor: AppColor.bluegreen,
        actions: [
          IconButton(
              onPressed: (){
                context.read<AuthenticationService>().signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
