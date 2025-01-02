import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mostrarAlerta( BuildContext context, String titulo, String subtitulo  ) {

 return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(titulo),
        content:  Text(subtitulo),
        actions: <Widget>[
          MaterialButton(
            child: const Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );


}