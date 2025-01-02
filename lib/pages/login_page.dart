import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/helpers/show_alert.dart';
import 'package:realtime_chat/services/auth_service.dart';
import 'package:realtime_chat/widgets/custom_button.dart';
import 'package:realtime_chat/widgets/labels.dart';
import 'package:realtime_chat/widgets/logos.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 190, 150),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Logo(title: 'Story'),
                MyCustomForm(),
                Labels(
                  route: 'register',
                  textPrimary: 'No tenes una cuenta?',
                  textSecondary: 'Crea una ahora',
                ),
                Text(
                  'Terminos y condiciones de uso',
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm(AuthService authService) async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    FocusScope.of(context).unfocus(); // Cierra el teclado

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final success = await authService.login(email, password);

    setState(() => isLoading = false);

    if (success) {
      // Navegar a la página principal (puedes ajustar esta ruta según tu app)
      Navigator.pushReplacementNamed(context, 'user');
    } else {
      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenciales incorrectas')),
      );
    }
  }

/* final _textFieldEmailKey = GlobalKey<FormFieldState>();
final _textFieldPasswordKey = GlobalKey<FormFieldState>();
 */
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 50),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            RepaintBoundary(
              child: TextFormField(
                /*  focusNode: emailFocusNode, */
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese un correo';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Ingrese un correo válido';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            RepaintBoundary(
              child: TextFormField(
                /* focusNode: passwordFocusNode, */
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: authService.autenticando
                  ? null
                  : () async {
                      print('Ingresando... ${authService.autenticando}');
                      final loginOk = await authService.login(
                          emailController.text, passwordController.text);
                      if (loginOk) {
                        Navigator.pushReplacementNamed(context, 'user');
                      }else{
                        mostrarAlerta(context, 'Login incorrecto', 'Revise sus credenciales');
                      }
                      FocusScope.of(context).unfocus();
                    },
              textButton: 'Ingrese',
              backgroundColor: const Color.fromARGB(255, 73, 97, 113),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
