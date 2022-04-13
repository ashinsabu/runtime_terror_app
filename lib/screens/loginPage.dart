import 'package:flutter/material.dart';
//TODO: fill out colors according to colour scheme picked
class loginPage extends StatefulWidget {
  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  late String? _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState> ();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.fromLTRB(50,0,50,50),
        child: Form(
          key: _formKey,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //TODO: add logo here
              Text("<LOGO HERE>"),
              SizedBox(height: 100,),
              TextFormField(
                validator: (String? input) {
                  if(input!.isEmpty){
                    return "Field cannot be empty";
                  }
                  return null;
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                    labelText: 'Email', prefixIcon: Icon(Icons.account_box_rounded), hintText: 'Enter your Email'
                ),
              ),
              TextFormField(
                validator: (String? input) {
                  if(input!= null && input.length < 6){
                    return "Password needs atleast 6 characters";
                  }
                  if(input == null || input == '')
                    return "Password cannot be empty";
                  return null;
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                    labelText: 'Password', prefixIcon: Icon(Icons.lock), hintText: 'Enter your Email'
                ),
                obscureText: true,
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle:TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: Text("Sign in",) ,
                onPressed: () {},
              ),


            ],
          ),
        ),
      ),
    );
  }
}
