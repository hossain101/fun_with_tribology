import 'package:flutter/material.dart';
import 'package:fun_with_tribology/constants.dart';
import 'package:fun_with_tribology/screens/app/components/rounded_button.dart';
import 'package:fun_with_tribology/screens/app/components/top_right_button.dart';

class AddHangmanQuestion extends StatelessWidget {
  static String id = 'add_hangman_question_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: KScreenDecoration(
          decorationChild: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //used Align to move the button to the right.
                TopRightButton(
                  title: '               Back',
                  btnIcon: Icons.arrow_back,
                  funcOnPressed: () => Navigator.pop(context),
                  btnPadding: EdgeInsets.only(left: 20),
                ),

                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RoundedButton(
                      title: 'Add Questions',
                      btnColor: Colors.grey.withOpacity(.6),
                      funcOnPressed: () {},
                    ),
                  ],
                ),

                Spacer(),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
