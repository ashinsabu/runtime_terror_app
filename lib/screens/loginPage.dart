import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:runtime_terror_app/services/authentication_service.dart';
import 'package:runtime_terror_app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
//TODO: fill out colors according to colour scheme picked
//TODO: test out edge cases of login security
//NOTE: Sign up functionality is not needed. It is better to have pharmacist application process that will be reviewed by third party,
//      verified and then added to the userlist.
class loginPage extends StatefulWidget {
  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  String? _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState> ();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loginFail=false;
  void dispose(){
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Widget build (BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: AppColor.neongreen,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.fromLTRB(
            width * 0.06, 0, width * 0.06, height * 0.065),
        child: Form(
          key: _formKey,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: width * 0.45,
                height: height * 0.24,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/logo2.png')
                  ),
                  // shape: BoxShape.circle

                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  "MedSafe",
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 2.0),
                        blurRadius: 4.0,
                        color: AppColor.green,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50,),
              TextFormField(
                validator: (String? input) {
                  if (input!.isEmpty) {
                    return "Field cannot be empty";
                  }
                  return null;
                },
                // onSaved: (input) { _email = input; print(_email);},
                controller: emailController,
                cursorColor: Colors.black,

                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.account_box_rounded),
                  hintText: 'Enter your Email',
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(),
                  errorText: (loginFail)? '' : null,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(

                // onSaved: (input) => _password = input,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Enter your Password',
                  errorStyle: TextStyle(fontSize: 14),
                  errorText: (loginFail)? 'Invalid Credentials' : null,
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColor.kellygreen,
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                  textStyle: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: Text("Sign in",),
                onPressed: () {
                      context.read<AuthenticationService>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      ).then((bool loggedin){ setState(() { loginFail=loggedin;}); print(loggedin);});
                },
              ),
              SizedBox(height: height*0.02,),
              RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    text: 'No account? ',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                            ..onTap = () {},
                        text: 'Apply for One.',
                        style: TextStyle(decoration: TextDecoration.underline, color: Colors.blueAccent)
                      )
                    ]

                  )
              )

            ],
          ),
        ),
      ),
    );
  }
}
