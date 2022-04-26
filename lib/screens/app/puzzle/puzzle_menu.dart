import 'package:flutter/material.dart';
import 'package:fun_with_tribology/constants.dart';
import 'package:fun_with_tribology/screens/app/components/rounded_button.dart';
import 'package:fun_with_tribology/screens/app/components/top_right_button.dart';
import 'package:fun_with_tribology/screens/app/puzzle/puzzle_scoreboard.dart';

class PuzzleMenu extends StatelessWidget {
  static String id = 'puzzle_menu';
  const PuzzleMenu({Key? key}) : super(key: key);

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
                          Navigator.pushNamed(context, PuzzleScoreBoard.id);
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
