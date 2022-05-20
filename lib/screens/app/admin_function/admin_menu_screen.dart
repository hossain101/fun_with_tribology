//Admin Email - admin@mail.com , password = 12345678

import 'package:flutter/material.dart';
import 'package:fun_with_tribology/constants.dart';
import 'package:fun_with_tribology/screens/app/admin_function/hangman/add_hangman_question_screen.dart';
import 'package:fun_with_tribology/screens/app/admin_function/puzzle/add_puzzle_question_screen.dart';
import 'package:fun_with_tribology/screens/app/components/top_right_button.dart';

import '../components/rounded_button.dart';

class AdminMenu extends StatelessWidget {
  static String id = 'admin_menu_screen';
  const AdminMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: KScreenDecoration(
          decorationChild: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //used Align to move the button to the right.
                TopRightButton(
                  title: 'Edit Profile',
                  btnIcon: Icons.person,
                  funcOnPressed: () => Null,
                  btnPadding: EdgeInsets.only(left: 20),
                ),

                //this is the widget for fun puzzle
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(70, 5, 70, 10),
                // ),
                //

                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RoundedButton(
                      title: 'Add Puzzle Question',
                      btnColor: Colors.grey.withOpacity(.6),
                      funcOnPressed: () {
                        Navigator.pushNamed(context, AddPuzzleQuestion.id);
                      },
                    ),
                    RoundedButton(
                      title: 'Add Hangman Questions',
                      btnColor: Colors.grey.withOpacity(.6),
                      funcOnPressed: () {
                        Navigator.pushNamed(context, AddHangmanQuestion.id);
                      },
                    ),
                  ],
                ),

                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
