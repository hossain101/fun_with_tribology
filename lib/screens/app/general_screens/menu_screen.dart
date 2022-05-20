import 'package:flutter/material.dart';
import 'package:fun_with_tribology/constants.dart';
import 'package:fun_with_tribology/screens/app/components/rounded_button.dart';
import 'package:fun_with_tribology/screens/app/components/top_right_button.dart';
import 'package:fun_with_tribology/screens/app/general_screens/editProfile_screen.dart';
import 'package:fun_with_tribology/screens/app/hangman/hangman_menu.dart';
import 'package:fun_with_tribology/screens/app/puzzle/puzzle_menu.dart';

class MenuScreen extends StatelessWidget {
  static String id = 'menu_screen';
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: KScreenDecoration(
        decorationChild: SafeArea(
          child: Column(
            children: [
              //used Align to move the button to the right.
              TopRightButton(
                title: 'Edit Profile',
                btnIcon: Icons.person,
                funcOnPressed: () =>
                    Navigator.pushNamed(context, EditProfile.id),
                btnPadding: EdgeInsets.only(left: 20),
              ),

              //this is the widget for fun puzzle
              Padding(
                padding: const EdgeInsets.fromLTRB(70, 5, 70, 10),
                child: Flexible(
                  child: Image.asset('images/puzzle3.gif'),
                ),
              ),
              RoundedButton(
                title: 'FUN PUZZLES',
                btnColor: Colors.grey.withOpacity(.6),
                funcOnPressed: () {
                  Navigator.pushNamed(context, PuzzleMenu.id);
                },
              ),

              Flexible(
                child: Image.asset('images/hangman.gif'),
              ),
              RoundedButton(
                title: 'FUN HANGMAN',
                btnColor: Colors.grey.withOpacity(.6),
                funcOnPressed: () {
                  Navigator.pushNamed(context, HangmanMenu.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
