import 'package:flutter/material.dart';
import 'package:fun_with_tribology/constants.dart';
import 'package:fun_with_tribology/screens/app/components/rounded_button.dart';
import 'package:fun_with_tribology/screens/app/components/top_right_button.dart';
import 'package:fun_with_tribology/screens/app/hangman/hangman_scoreboard.dart';

class HangmanMenu extends StatelessWidget {
  static String id = 'hangman_menu';
  const HangmanMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: KScreenDecoration(
          decorationChild: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TopRightButton(
                //   title: 'Back',
                //   btnIcon: Icons.arrow_back_ios_outlined,
                //   funcOnPressed: () => Navigator.pop(context),
                //   btnPadding: EdgeInsets.only(left: 70),
                // ),
                //
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      RoundedButton(
                        title: 'Score Board',
                        btnColor: Colors.grey.withOpacity(.6),
                        funcOnPressed: () {
                          Navigator.pushNamed(context, HangmanScoreBoard.id);
                        },
                      ),
                      RoundedButton(
                        title: 'Play Game',
                        btnColor: Colors.grey.withOpacity(.6),
                        funcOnPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
