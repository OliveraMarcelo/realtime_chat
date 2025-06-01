import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/helpers/show_alert.dart';
import 'package:realtime_chat/services/auth_service.dart';
import 'package:realtime_chat/widgets/custom_button.dart';
import 'package:realtime_chat/widgets/custom_input_field.dart';
import 'package:realtime_chat/widgets/labels.dart';
import 'package:realtime_chat/widgets/logos.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 190, 150),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Logo(
                    title: 'Registro',
                  ),
                  Form(),
                  Labels(
                    route: 'login',
                    textPrimary: 'Ya tenes una cuenta?',
                    textSecondary: 'Ingresa con tu cuenta',
                  ),
                  Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
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
    final authService = Provider.of<AuthService>(context);

    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Container(
      margin: const EdgeInsets.only(top: 50),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
           RepaintBoundary(
              child: TextFormField(
                /*  focusNode: emailFocusNode, */
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
            ),
            const SizedBox(height: 10),
            
             RepaintBoundary(
              child: TextFormField(
                /*  focusNode: emailFocusNode, */
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
            ),
            const SizedBox(height: 10),
            RepaintBoundary(
              child: TextFormField(
                /* focusNode: passwordFocusNode, */
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
            ),
          const SizedBox(
            height: 10,
          ),
        /*   CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            keyboardType: TextInputType.visiblePassword,
            isPassword: true,
            textController: passwordController,
          ),
          const SizedBox(
            height: 10,
          ), */
          CustomButton(
              onPressed: authService.autenticando
                  ? null
                  : () async {
                      final registerOk = await authService.register(
                          nameController.text,
                          emailController.text,
                          passwordController.text);
                      if (registerOk) {
                        Navigator.pushReplacementNamed(context, 'login');
                      } else {
                        mostrarAlerta(context, 'Register incorrecto',
                            'Revise sus credenciales');
                      }
                      FocusScope.of(context).unfocus();
                    },
              textButton: 'Ingrese',
              backgroundColor: Colors.blue,
              textColor: Colors.white)
        ],
      ),
    );
  }
}
