import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fun_with_tribology/constants.dart';
import 'package:fun_with_tribology/screens/app/components/rounded_button.dart';
import 'package:fun_with_tribology/screens/app/authentication/login_screen.dart';
import 'package:fun_with_tribology/screens/app/authentication/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

//With TickerProviderMixin Provides a single Ticker that is configured to only tick while the current tree is enabled, as defined by TickerMode.
class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController
      _controller; //A controller that allows to control animation such as forward,reverse or stop
  late Animation _animation;

  //InitState, it is the first thing that runs when this page loads.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.decelerate);
    _controller.forward();
    _controller.addListener(
      () {
        setState(() {});
        print(_animation.value);
      },
    );
  }

  //The build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent.withOpacity(_controller.value),
      //KScreenDecoration is in the constants.dart, it is a container used for the decoration of the welcome,login and registration screen.
      body: KScreenDecoration(
        decorationChild: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Image.asset('images/piston.gif'),
                ),
                Flexible(
                  child: TypewriterAnimatedTextKit(
                    text: const ['Fun with Tribology'],
                    textStyle: kAnimatedTextKitTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                RoundedButton(
                  title: 'Login',
                  btnColor: Colors.black12.withOpacity(0.05),
                  funcOnPressed: () =>
                      Navigator.pushNamed(context, LoginScreen.id),
                ),
                RoundedButton(
                  title: 'Register',
                  btnColor: Colors.black12.withOpacity(0.05),
                  funcOnPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
