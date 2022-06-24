import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fun_with_tribology/constants.dart';
import 'package:fun_with_tribology/screens/app/puzzle/puzzle_widgets.dart';

class PuzzleQuestion extends StatefulWidget {
  static String id = 'puzzle_question';




  @override
  State<PuzzleQuestion> createState() => _PuzzleQuestionState();
}

class _PuzzleQuestionState extends State<PuzzleQuestion> {
  String? question = 'will this work',answer='yes'.toUpperCase();
  int correctCount = 0;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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

                            if(correctCount>=answer!.length){
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
                            print(PuzzleGameLogic
                                .selectedChar.length);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          fillColor: PuzzleGameLogic.selectedChar
                              .contains(alphabets)
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
