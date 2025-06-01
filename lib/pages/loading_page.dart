import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/pages/users_page.dart';
import 'package:realtime_chat/services/auth_service.dart';
import 'package:realtime_chat/services/socket_service.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: checkLoginState(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return const Center(
          child: Text('Loading...'),
        );
      },
    ));
  }

  Future<void> checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();
    print(autenticado);
    if (autenticado) {
      //TODO: conectar al socket server
      socketService.connect();
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const UsersPage(),
            transitionDuration: const Duration(milliseconds: 0),
          ));
    } else {
      //TODO: desconectar al socket server
      Navigator.pushReplacementNamed(context, 'login');

      socketService.disconnect();
    }
  }
}
