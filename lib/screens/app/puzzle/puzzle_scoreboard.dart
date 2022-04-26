import 'package:flutter/material.dart';
import 'package:fun_with_tribology/constants.dart';

class PuzzleScoreBoard extends StatefulWidget {
  static String id = 'puzzle_scoreboard';
  const PuzzleScoreBoard({Key? key}) : super(key: key);

  @override
  State<PuzzleScoreBoard> createState() => _PuzzleScoreBoardState();
}

class _PuzzleScoreBoardState extends State<PuzzleScoreBoard> {
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
