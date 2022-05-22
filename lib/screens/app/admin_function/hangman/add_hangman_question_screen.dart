import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fun_with_tribology/constants.dart';
import 'package:fun_with_tribology/screens/app/components/rounded_button.dart';
import 'package:fun_with_tribology/screens/app/components/top_right_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;
final _auth = FirebaseAuth.instance;

//

class AddHangmanQuestion extends StatelessWidget {
  static String id = 'add_hangman_question_screen';
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

  QuestionField _questionField1 = QuestionField(1);
  QuestionField _questionField2 = QuestionField(2);
  QuestionField _questionField3 = QuestionField(3);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: KScreenDecoration(
          decorationChild: SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _questionField1,
                  _questionField2,
                  _questionField3,
                  RaisedButton(
                    onPressed: () {
                      _firestore.collection('HangmanQuestion1').add({
                        'questionNo': _questionField1.questionNo,
                        'word': _questionField1.word,
                        'clue': _questionField1.clue,
                        'time': FieldValue.serverTimestamp()
                      });

                      _firestore.collection('HangmanQuestion2').add({
                        'questionNo': _questionField2.questionNo,
                        'word': _questionField2.word,
                        'clue': _questionField2.clue,
                        'time': FieldValue.serverTimestamp()
                      });
                      _firestore.collection('HangmanQuestion3').add({
                        'questionNo': _questionField3.questionNo,
                        'word': _questionField3.word,
                        'clue': _questionField3.clue,
                        'time': FieldValue.serverTimestamp()
                      });
                    },
                    child: Text("submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionField extends StatelessWidget {
  late String word, clue;
  late int questionNo;

  QuestionField(this.questionNo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: '$questionNo)Word',
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'Enter a word',
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
              decoration: InputDecoration(
                labelText: 'Clue',
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Enter a clue',
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
