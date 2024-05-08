import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        /* para bajar  */
        child: Container(
          width: 160,
          child: Column(
            children: [
              Image(image: AssetImage('/tag-logo.png')),
              SizedBox(
                height: 20,
              ),
              Text(
                'Messenger',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
