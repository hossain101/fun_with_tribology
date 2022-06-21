import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fun_with_tribology/constants.dart';
// ignore_for_file: prefer_const_constructors

final _firestore = FirebaseFirestore.instance;

class HangmanScoreBoard extends StatefulWidget {
  static String id = 'hangman_scoreboard';

  const HangmanScoreBoard({Key? key}) : super(key: key);

  @override
  State<HangmanScoreBoard> createState() => _HangmanScoreBoardState();
}

class _HangmanScoreBoardState extends State<HangmanScoreBoard> {
  String? player, score;

  List scores = [];
  List players = [];

  void getScore() async {
    final gamePlayers = await _firestore.collection('score').get();
    for (int i = 0; i < gamePlayers.size; i++) {
      score = (gamePlayers.docs[i]['score']);
      scores.add(score);

      player = (gamePlayers.docs[i]['sender']);
      players.add(player);
    }
  }
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getScore();
    setState(() {});
  }
  Map scoreMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: KScreenDecoration(
          decorationChild: Column(
        children: [
          Center(
            child: Text(
              'Score Board',
              style: TextStyle(fontSize: 40),
            ),
          ),
          Expanded(
            child: ListView(
              children: [

                Text("Big balls"
                ),
              ],
            ),
          ),
        ],
      )),
    ));
  }
}
