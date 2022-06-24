import 'package:flutter/material.dart';



Widget Letter(String character, bool hidden) {
  return Container(
    height: 65,
    width: 50,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.deepPurpleAccent),
    child: Visibility(
      visible: !hidden,
      child: Text(
        character,
        style: TextStyle(
            color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 40.0),
      ),
    ),
  );
}

List<String> alphabets = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z',
];
