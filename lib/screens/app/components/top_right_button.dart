import 'package:flutter/material.dart';

class TopRightButton extends StatelessWidget {
  VoidCallback funcOnPressed;
  String title;
  IconData btnIcon;
  EdgeInsetsGeometry btnPadding;

  TopRightButton(
      {required this.title,
      required this.btnIcon,
      required this.funcOnPressed,
      required this.btnPadding});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        height: 50,
        width: 150,
        child: MaterialButton(
          padding: btnPadding,
          onPressed: funcOnPressed,
          child: Row(
            children: [
              Icon(btnIcon),
              Text(
                title,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
