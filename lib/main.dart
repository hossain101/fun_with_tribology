import 'package:flutter/material.dart';
import 'package:fun_with_tribology/screens/app/login_screen.dart';
import 'package:fun_with_tribology/screens/app/registration_screen.dart';
import 'package:fun_with_tribology/screens/app/welcome_screen.dart';

void main() {
  runApp(const FunWithTribology());
}

class FunWithTribology extends StatelessWidget {
  const FunWithTribology({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
      },
    );
  }
}
