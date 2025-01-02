import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message(
      {super.key,
      required this.text,
      required this.uid,
      required this.animationController});
  final String text;
  final String uid;
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity:animationController,
        child: SizeTransition(
          sizeFactor: CurvedAnimation(
            parent: animationController,
            curve: Curves.easeOut
          ),
          child: Container(
              child: uid == '1'
                  ? MyMessage(
                      text: text,
                    )
                  : NotMyMessage(
                      text: text,
                    )),
        ));
  }
}

class NotMyMessage extends StatelessWidget {
  const NotMyMessage({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 73, 97, 113),
                borderRadius: BorderRadius.circular(20)),
            child: Text(text, style: const TextStyle(color: Colors.white)),
          ),
        ));
  }
}

class MyMessage extends StatelessWidget {
  const MyMessage({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 239, 190, 150),
              borderRadius: BorderRadius.circular(20)),
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
