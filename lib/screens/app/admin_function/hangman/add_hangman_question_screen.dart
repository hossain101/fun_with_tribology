import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fun_with_tribology/constants.dart';
import 'package:fun_with_tribology/screens/app/components/rounded_button.dart';
import 'package:fun_with_tribology/screens/app/components/top_right_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//here the firestore initialization took place
final _firestore = FirebaseFirestore.instance;
User? loggedInUser;
final _auth = FirebaseAuth.instance;

// This is a stateless widget because the screen doesn't need to be updated

class AddHangmanQuestion extends StatefulWidget {
  static String id = 'add_hangman_question_screen';

  @override
  State<AddHangmanQuestion> createState() => _AddHangmanQuestionState();
}

class _AddHangmanQuestionState extends State<AddHangmanQuestion> {
  final GlobalKey<FormState> _formKey = GlobalKey();

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

  var questionNumber;

  Future<void> getQuestionNumber() async {
    final hangmanQuestion =
        await _firestore.collection('HangmanQuestion').get();

    print(
        'This is the question number   ${hangmanQuestion.docs[hangmanQuestion.size - 1]['questionNo']}');

    questionNumber = await int.parse(
            hangmanQuestion.docs[hangmanQuestion.size - 1]['questionNo']) +
        1;

    print('What will be the value of this? $questionNumber');
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getQuestionNumber();
  }

  QuestionField _questionField1 = QuestionField();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: KScreenDecoration(
          decorationChild: SafeArea(
            child: ListView(
              children: [
                _questionField1,
                RaisedButton(
                  onPressed: () {
                    final questionCollection =
                        _firestore.collection('HangmanQuestion');

                    questionCollection
                        .doc('question${questionNumber.toString()}')
                        .set({
                      'questionNo': '${questionNumber.toString()}',
                      'word': _questionField1.word,
                      'clue': _questionField1.clue,
                      'time': FieldValue.serverTimestamp()
                    });

                    Fluttertoast.showToast(msg: 'Question Upload Successful');

                    Navigator.pop(context);
                  },
                  child: Text("submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionField extends StatelessWidget {
  late String word, clue;

  QuestionField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextFormField(
            style: TextStyle(color: Colors.white, fontSize: 25),
            decoration: InputDecoration(
              labelText: 'Word',
              labelStyle: TextStyle(color: Colors.white, fontSize: 45),
              hintText: 'Enter a word',
              hintStyle: TextStyle(color: Colors.white70, fontSize: 20),
            ),
            onChanged: (value) {
              word = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a word';
              }
              return null;
            },
          ),
          TextFormField(
              style: TextStyle(color: Colors.white, fontSize: 25),
              decoration: InputDecoration(
                labelText: 'Clue',
                labelStyle: TextStyle(color: Colors.white, fontSize: 45),
                hintText: 'Enter a clue',
                hintStyle: TextStyle(color: Colors.white70, fontSize: 20),
              ),
              onChanged: (value) {
                clue = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a clue';
                }
                return null;
              }),
        ],
      ),
    );
  }
}
