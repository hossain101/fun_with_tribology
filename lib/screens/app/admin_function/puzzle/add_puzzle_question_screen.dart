import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fun_with_tribology/constants.dart';
import 'package:fun_with_tribology/screens/app/components/rounded_button.dart';
import 'package:fun_with_tribology/screens/app/components/top_right_button.dart';

final GlobalKey<FormState> _formKey = GlobalKey();
final _firestore = FirebaseFirestore.instance;
User? loggedInUser;
final _auth = FirebaseAuth.instance;

class AddPuzzleQuestion extends StatefulWidget {
  static String id = 'add_puzzle_question_screen';

  @override
  State<AddPuzzleQuestion> createState() => _AddPuzzleQuestionState();
}

class _AddPuzzleQuestionState extends State<AddPuzzleQuestion> {



  QuestionField _questionField = QuestionField();

 var questionNumber ;

  Future<void> getQuestionNumber() async {
    final PuzzleQuestions =
    await _firestore.collection('PuzzleQuestions').get();

    print(
        'This is the question number   ${PuzzleQuestions.docs[PuzzleQuestions.size - 1]['questionNo']}');

    questionNumber =  await int.parse(
        PuzzleQuestions.docs[PuzzleQuestions.size - 1]['questionNo']) + 1;

    print('What will be the value of this? $questionNumber');
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getQuestionNumber();
    setState((){getQuestionNumber();});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: KScreenDecoration(
          decorationChild: SafeArea(
            child:ListView(

              children: [
                _questionField,
                RaisedButton(
                  onPressed: () {

                    final questionCollection =
                    _firestore.collection('PuzzleQuestions');

                    questionCollection
                        .doc('question${questionNumber.toString()}')
                        .set({
                      'questionNo': '${questionNumber.toString()}',
                      'question': _questionField.question,
                      'answer': _questionField.answer,
                      'link':_questionField.link,
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
    ));
  }
}

class QuestionField extends StatelessWidget {
  late String question, answer,link;

  QuestionField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextFormField(
        //    key:_formKey ,
            style: TextStyle(color: Colors.white, fontSize: 25),
            decoration: InputDecoration(
              labelText: 'Question',
              labelStyle: TextStyle(color: Colors.white, fontSize: 45),
              hintText: 'Enter a Question',
              hintStyle: TextStyle(color: Colors.white70, fontSize: 20),
            ),
            onChanged: (value) {
              question = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a Question';
              }
              return null;
            },
          ),
          TextFormField(
           // key: _formKey,
              style: TextStyle(color: Colors.white, fontSize: 25),
              decoration: InputDecoration(
                labelText: 'Answer',
                labelStyle: TextStyle(color: Colors.white, fontSize: 45),
                hintText: 'Enter an Answer',
                hintStyle: TextStyle(color: Colors.white70, fontSize: 20),
              ),
              onChanged: (value) {
                answer = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an Answer';
                }
                return null;
              }),
          TextFormField(

          //  key: _formKey,
              style: TextStyle(color: Colors.white, fontSize: 25),
              decoration: InputDecoration(
                labelText: 'Image Link',
                labelStyle: TextStyle(color: Colors.white, fontSize: 45),
                hintText: 'Enter an Image Link',
                hintStyle: TextStyle(color: Colors.white70, fontSize: 20),
              ),
              onChanged: (value) {
                link = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an Image Link';
                }
                return null;
              }),
        ],
      ),
    );
  }
}
