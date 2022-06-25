import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fun_with_tribology/constants.dart';
import 'package:fun_with_tribology/screens/app/puzzle/puzzle_widgets.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? loggedInUser;

class PuzzleQuestion extends StatefulWidget {
  static String id = 'puzzle_question';

  @override
  State<PuzzleQuestion> createState() => _PuzzleQuestionState();
}

class _PuzzleQuestionState extends State<PuzzleQuestion> {

  int correctCount = 0;
  bool isLoading = false;

  int movementCount = 0;

  var question , answer ;

  Future<void> getQuestion() async {
    setState(() {
      isLoading = true;
    });
    final puzzleQuestion = await _firestore.collection('PuzzleQuestions').get();

    print(puzzleQuestion.docs[puzzleQuestion.size - 1]['question']);

    question = puzzleQuestion.docs[puzzleQuestion.size - 1]['question']
        .toString()
        .toUpperCase();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> getAnswer() async {
    setState(() {
      isLoading = true;
    });
    final puzzleQuestion = await _firestore.collection('PuzzleQuestions').get();

    print(puzzleQuestion.docs[puzzleQuestion.size - 1]['answer']);

    answer = puzzleQuestion.docs[puzzleQuestion.size - 1]['answer']
        .toString()
        .toUpperCase();

    setState(() {
      isLoading = false;
    });
  }





  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  //from this method i can call a particular field from a particular document that is in a particular collection
  void getMovementCount() async {
    final step1 = _firestore
        .collection('PuzzleMovement')
        .doc('${loggedInUser!.email}')
        .get();

    final step2 = step1.then((document1) {
      print(document1.get('movementCount'));

      movementCount = document1.get('movementCount');
    });
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getAnswer();
    getQuestion();
    getCurrentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
          : SafeArea(
        child: KScreenDecoration(
          decorationChild: Container(
            child: Column(
              children: [
                AutoSizeText(
                  question!.toString(),
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                //hidden word
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: answer
                        .toString()
                        .split('')
                        .map(
                          (e) => Letter(
                            e.toUpperCase(),
                            !PuzzleGameLogic.selectedChar.contains(e),
                          ),
                        )
                        .toList(),
                  ),
                ),

                //keyboard
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
                          onPressed: PuzzleGameLogic.selectedChar
                                  .contains(alphabets)
                              ? null
                              : () {
                                  getMovementCount();
                                  setState(() {
                                    print(PuzzleGameLogic.selectedChar);
                                    PuzzleGameLogic.selectedChar
                                        .add(alphabets.toUpperCase());
                                    // getWord();
                                  });

                                  //  score = ((correctCount/PuzzleGameLogic.selectedChar.length) *100) ;

                                  if (!answer!.split('').contains(
                                        alphabets.toUpperCase(),
                                      )) {
                                    PuzzleGameLogic.tries++;
                                  }
                                  if (answer!.split('').contains(
                                        alphabets.toUpperCase(),
                                      )) {
                                    correctCount++;
                                  }

                                  if (correctCount >= answer!.length) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    PuzzleGameLogic.tries = 0;
                                    PuzzleGameLogic.selectedChar.clear();

                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                  // gameWon();

                                  if (PuzzleGameLogic.tries >= 6) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    PuzzleGameLogic.tries = 0;
                                    PuzzleGameLogic.selectedChar.clear();

                                    setState(() {
                                      isLoading = false;
                                    });

                                    //   if (win ==true) {
                                    //     Navigator.pushReplacementNamed(
                                    //         context, HangmanScoreBoard.id);
                                    //   }
                                  }

                                  print(PuzzleGameLogic.tries);
                                  print(PuzzleGameLogic.selectedChar.length);
                                },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          fillColor:
                              PuzzleGameLogic.selectedChar.contains(alphabets)
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

class PuzzleGameLogic {
  static int tries = 0;
  static List<String> selectedChar = [];
}
