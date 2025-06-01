import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/models/user.dart';
import 'package:realtime_chat/services/auth_service.dart';
import 'package:realtime_chat/services/chat_service.dart';
import 'package:realtime_chat/services/socket_service.dart';
import 'package:realtime_chat/services/usuarios_service.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final usuarioService = UsuariosService();

  List<Usuario> users = [];
    late AuthService authService ;
    late SocketService  socketService ;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _loadUsers();
    authService = Provider.of<AuthService>(context,listen: false);
    socketService = Provider.of<SocketService>(context,listen: false);
  }

  @override
  Widget build(BuildContext context) {

    ServerStatus connectionStatus = socketService.serverStatus;

    final usuario = authService.usuario;
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: const Color.fromARGB(255, 239, 190, 150),
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              final logoutOk = await authService.logout();

              if (logoutOk) {
                if (socketService.serverStatus == ServerStatus.Online) {
                  socketService.disconnect();
                }
                Navigator.pushReplacementNamed(context, "login");
              }
            },
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: connectionStatus == ServerStatus.Online
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    )
                  : connectionStatus == ServerStatus.Offline
                      ? const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        )
                      : const Icon(Icons.refresh, color: Colors.white),
              // child: Icon(Icons.offline_bolt, color: Colors.red),
              // child: Icon(Icons.check_circle, color: Colors.green),
            )
          ],
          title:
              Center(child: Text(usuario != null ? usuario.nombre : 'Usuario')),
        ),
        body: SmartRefresher(
            controller: _refreshController,
            onRefresh: _loadUsers,
            header: const WaterDropHeader(
              complete: Icon(Icons.check, color: Colors.white),
              refresh:
                  Icon(Icons.check, color: Color.fromARGB(255, 239, 190, 150)),
              waterDropColor: Color.fromARGB(255, 239, 190, 150),
            ),
            child: ListViewUsers(users: users)));
  }

  _loadUsers() async {
    //await Future.delayed(const Duration(milliseconds: 1000));
    users = await usuarioService.getUsuarios();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}

class ListViewUsers extends StatelessWidget {
  const ListViewUsers({
    super.key,
    required this.users,
  });

  final List<Usuario> users;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return UserListTile(user: users[index]);
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: users.length);
  }
}

class UserListTile extends StatelessWidget {
  const UserListTile({
    super.key,
    required this.user,
  });

  final Usuario user;

  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);

    return ListTile(
      onTap: () {
        chatService.usuarioPara = user;
        Navigator.pushReplacementNamed(context, 'chat');
      },
      title: Text(user.nombre),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 239, 190, 150),
        child: Text(user.nombre.substring(0, 2),
            style: const TextStyle(color: Colors.white)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: user.online ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }
}
