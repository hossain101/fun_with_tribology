import 'package:flutter/material.dart';
import 'package:fun_with_tribology/constants.dart';

class HangmanScoreBoard extends StatefulWidget {
  static String id = 'hangman_scoreboard';
  const HangmanScoreBoard({Key? key}) : super(key: key);

  @override
  State<HangmanScoreBoard> createState() => _HangmanScoreBoardState();
}

class _HangmanScoreBoardState extends State<HangmanScoreBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: KScreenDecoration(
        decorationChild: Column(
          children: [],
        ),
      ),
    ));
  }
}
