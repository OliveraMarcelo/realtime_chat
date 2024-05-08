import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Logo(),
            Form(),
            Labels(),
            Text(
              'Terminos y condiciones de uso',
              style: TextStyle(fontWeight: FontWeight.w200),
            )
          ],
        ));
  }
}

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

class Form extends StatefulWidget {
  const Form({super.key});

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(),
        TextFormField(),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () {}, child: Text('Ingresar')),
      ],
    );
  }
}

class Labels extends StatelessWidget {
  const Labels({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'No tienes cuenta ? ',
          style: TextStyle(
              color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w200),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Crea una ahora ',
          style: TextStyle(
              color: Colors.blue[600],
              fontSize: 15,
              fontWeight: FontWeight.w200),
        )
      ],
    );
  }
}
