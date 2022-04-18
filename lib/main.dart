import 'package:flutter/material.dart';
import 'package:fun_with_tribology/screens/welcome_screen.dart';

void main() {
  runApp(const FunWithTribology());
}

class FunWithTribology extends StatelessWidget {
  const FunWithTribology({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {WelcomeScreen.id: (context) => WelcomeScreen()},
    );
  }
}
