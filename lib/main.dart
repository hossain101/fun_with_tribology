import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fun_with_tribology/screens/app/editProfile_screen.dart';
import 'package:fun_with_tribology/screens/app/login_screen.dart';
import 'package:fun_with_tribology/screens/app/menu_screen.dart';
import 'package:fun_with_tribology/screens/app/registration_screen.dart';
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
      },
    );
  }
}
