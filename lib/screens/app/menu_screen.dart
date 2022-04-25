import 'package:flutter/material.dart';
import 'package:fun_with_tribology/constants.dart';
import 'package:fun_with_tribology/screens/app/components/rounded_button.dart';
import 'package:fun_with_tribology/screens/app/editProfile_screen.dart';

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
              Align(
                alignment: Alignment.topRight,
                child: Flexible(
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: MaterialButton(
                      padding: EdgeInsets.only(left: 20),
                      onPressed: () {
                        Navigator.pushNamed(context, EditProfile.id);
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.person),
                          Text(
                            'Edit Profile',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
                funcOnPressed: () {},
              ),

              Flexible(
                child: Image.asset('images/hangman.gif'),
              ),
              RoundedButton(
                title: 'FUN HANGMAN',
                btnColor: Colors.grey.withOpacity(.6),
                funcOnPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
