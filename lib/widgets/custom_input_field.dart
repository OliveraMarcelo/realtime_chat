import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;
  const CustomInput(
      {super.key,
      required this.icon,
      required this.placeholder,
      required this.textController,
      required this.keyboardType,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0, 5),
                  blurRadius: 5)
            ]),
        child: TextFormField(
          controller: textController,
          obscureText: isPassword,
          autocorrect: false,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              prefixIcon: Icon(icon),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: placeholder),
        ));
  }
}
