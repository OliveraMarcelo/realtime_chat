import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  void Function()? onPressed;
  final String textButton;
  final Color backgroundColor;
  final Color textColor;

   CustomButton(
      {super.key,
      this.onPressed,
      required this.textButton,
      required this.backgroundColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStatePropertyAll(5),
            backgroundColor: MaterialStateProperty.all(backgroundColor)),
        onPressed: onPressed,
        child: Container(
            width: double.infinity,
            height: 55,
            child: Center(
              child: Text(
                textButton,
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            )));
  }
}
