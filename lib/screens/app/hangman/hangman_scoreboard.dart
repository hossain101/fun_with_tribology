import 'dart:ffi';

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

  bool isLoading = false;

  List scores = [];
  List players = [];

  void getScore() async {
    final gamePlayers = await _firestore.collection('score').get();
    for (int i = 0; i < gamePlayers.size; i++) {
      setState(() {});
      score = (gamePlayers.docs[i]['score']);
      scores.add(score);

      player = (gamePlayers.docs[i]['sender']);
      players.add(player);
    }
  }

  List scoreData = [];
  List sortedScoreData = [];

  getSortedScoreData(List scoreData) {
    for (int i = 0; i <= scoreData.length; i++) {}
  }

  Future getScoreList() async {

    setState((){isLoading = true;});
    try {
      await _firestore.collection('score').get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          scoreData.add(element.data());
          setState((){isLoading = false;});
        });
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getScoreList();
    getScore();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child:isLoading
          ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
          : KScreenDecoration(
          decorationChild: Column(
        children: [
          Center(
            child: Text(
              'Score Board',
              style: TextStyle(fontSize: 40.0, color: Colors.white70),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: scoreData.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 5.0, color: Colors.white70),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Score : ${scoreData[index]['score']} \n Player: ${scoreData[index]['sender']} ',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )),
    ));
  }
}
