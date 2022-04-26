import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../constants.dart';
import '../components/rounded_button.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email, password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: KScreenDecoration(
        decorationChild: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 250.0,
                    alignment: Alignment.center,
                    child: AnimatedTextKit(
                      totalRepeatCount: 5,
                      animatedTexts: [
                        FlickerAnimatedText(
                          'Learning',
                          textStyle: TextStyle(
                            fontSize: 55.0,
                            color: Colors.white.withOpacity(.7),
                          ),
                          speed: Duration(seconds: 2),
                        ),
                        FlickerAnimatedText(
                          'Made',
                          textStyle: TextStyle(
                            fontSize: 55.0,
                            color: Colors.white.withOpacity(.7),
                          ),
                          speed: Duration(seconds: 2),
                        ),
                        FlickerAnimatedText(
                          'Fun',
                          textStyle: TextStyle(
                            fontSize: 55.0,
                            color: Colors.white.withOpacity(.7),
                          ),
                          speed: Duration(seconds: 2),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your E-mail',
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password'),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    title: 'Register',
                    btnColor: Colors.black12.withOpacity(0.05),
                    funcOnPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      print(email);
                      print(password);
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          Navigator.pushNamed(context, LoginScreen.id);
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
