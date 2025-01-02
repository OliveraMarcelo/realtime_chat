import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;
  const Logo({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        /* para bajar  */
        child: Container(
          width: 160,
          child: Column(
            children: [
              Image(image: AssetImage('/logo.jpeg')),
              SizedBox(
                height: 20,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
