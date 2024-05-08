import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Labels extends StatelessWidget {
  final String route;
  final String textPrimary;
  final String textSecondary;

  const Labels(
      {super.key,
      required this.route,
      required this.textPrimary,
      required this.textSecondary});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          textPrimary,
          style: TextStyle(
              color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w200),
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.popAndPushNamed(context, route);
          },
          child: Text(
            textSecondary,
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: 15,
                fontWeight: FontWeight.w200),
          ),
        )
      ],
    );
  }
}
