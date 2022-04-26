import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fun_with_tribology/screens/app/editProfile_screen.dart';
import 'package:fun_with_tribology/screens/app/authentication/login_screen.dart';
import 'package:fun_with_tribology/screens/app/hangman/hangman_menu.dart';
import 'package:fun_with_tribology/screens/app/hangman/hangman_scoreboard.dart';
import 'package:fun_with_tribology/screens/app/menu_screen.dart';
import 'package:fun_with_tribology/screens/app/authentication/registration_screen.dart';
import 'package:fun_with_tribology/screens/app/puzzle/puzzle_menu.dart';
import 'package:fun_with_tribology/screens/app/puzzle/puzzle_scoreboard.dart';
import 'package:fun_with_tribology/screens/app/welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FunWithTribology());
}

class FunWithTribology extends StatelessWidget {
  const FunWithTribology({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.acmeTextTheme(),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        MenuScreen.id: (context) => const MenuScreen(),
        EditProfile.id: (context) => EditProfile(),
        PuzzleMenu.id: (context) => PuzzleMenu(),
        HangmanMenu.id: (context) => HangmanMenu(),
        PuzzleScoreBoard.id: (context) => PuzzleScoreBoard(),
        HangmanScoreBoard.id: (context) => HangmanScoreBoard(),
      },
    );
  }
}
