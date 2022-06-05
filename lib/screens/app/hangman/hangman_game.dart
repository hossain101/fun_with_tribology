import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fun_with_tribology/constants.dart';
import 'package:fun_with_tribology/screens/app/hangman/hangman_widgets.dart';

final _firestore = FirebaseFirestore.instance;

class HangmanGame extends StatefulWidget {
  static String id = 'hangman_game';
  const HangmanGame({Key? key}) : super(key: key);

  @override
  State<HangmanGame> createState() => _HangmanGameState();
}

class _HangmanGameState extends State<HangmanGame> {
  String? word;
  String? clue;

  Future<void> getWord() async {
    final hangmanQuestion3 =
        await _firestore.collection('HangmanQuestion').get();

    print(hangmanQuestion3.docs[hangmanQuestion3.size - 1]['word']);

    word = hangmanQuestion3.docs[hangmanQuestion3.size - 1]['word']
        .toString()
        .toUpperCase();
  }

  Future<void> getClue() async {
    final hangmanQuestion1 =
        await _firestore.collection('HangmanQuestion').get();

    print(hangmanQuestion1.docs[hangmanQuestion1.size - 1]['clue']);

    clue = hangmanQuestion1.docs[hangmanQuestion1.size - 1]['clue']
        .toString()
        .toUpperCase();
    setState(() {});
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getWord();
    getClue();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: KScreenDecoration(
          decorationChild: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Stack(
                    children: [
                      //In here I will be making the figure
                      figureImage(
                        HangmanGameLogic.tries >= 0,
                        "images/hangman/0.png",
                      ),
                      figureImage(
                        HangmanGameLogic.tries >= 1,
                        "images/hangman/1.png",
                      ),
                      figureImage(
                        HangmanGameLogic.tries >= 2,
                        "images/hangman/2.png",
                      ),
                      figureImage(
                        HangmanGameLogic.tries >= 3,
                        "images/hangman/3.png",
                      ),
                      figureImage(
                        HangmanGameLogic.tries >= 4,
                        "images/hangman/4.png",
                      ),
                      figureImage(
                        HangmanGameLogic.tries >= 5,
                        "images/hangman/5.png",
                      ),
                      figureImage(
                        HangmanGameLogic.tries >= 6,
                        "images/hangman/6.png",
                      ),
                    ],
                  ),
                ),
                AutoSizeText(
                  clue.toString(),
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: word
                        .toString()
                        .split('')
                        .map(
                          (e) => Letter(
                            e.toUpperCase(),
                            !HangmanGameLogic.selectedChar.contains(e),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    width: double.infinity,
                    height: 350,
                    child: GridView.count(
                      crossAxisCount: 7,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      padding: EdgeInsets.all(8.0),
                      children: alphabets.map((alphabets) {
                        return RawMaterialButton(
                          child: Text(
                            alphabets,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70),
                          ),
                          onPressed:
                              HangmanGameLogic.selectedChar.contains(alphabets)
                                  ? null
                                  : () {
                                      setState(() {
                                        print(HangmanGameLogic.selectedChar);
                                        HangmanGameLogic.selectedChar
                                            .add(alphabets.toUpperCase());
                                        // getWord();
                                      });

                                      if (!word!.split('').contains(
                                            alphabets.toUpperCase(),
                                          )) {
                                        HangmanGameLogic.tries++;
                                      }
                                    },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          fillColor:
                              HangmanGameLogic.selectedChar.contains(alphabets)
                                  ? Colors.black87
                                  : Colors.blue,
                        );
                      }).toList(),
                    ),
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

class HangmanGameLogic {
  static int tries = 0;
  static List<String> selectedChar = [];
}
