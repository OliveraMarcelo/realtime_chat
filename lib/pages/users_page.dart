import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/models/user.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final users = [
    Usuario(nombre: 'Jhuly', online: true, email: 'email', uid: '1'),
    Usuario(nombre: 'Dan', online: false, email: 'email', uid: '2')
  ];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Color.fromARGB(255, 239, 190, 150),
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
              // child: Icon(Icons.offline_bolt, color: Colors.red),
              // child: Icon(Icons.check_circle, color: Colors.green),
            )
          ],
          title: const Center(child:  Text('Marcelo Olivera')),
        ),
        body: SmartRefresher(
            controller: _refreshController,
            onRefresh: _loadUsers,
            header: const WaterDropHeader(
              complete: Icon(Icons.check, color: Colors.white),
              refresh: Icon(Icons.check,
                  color: Color.fromARGB(255, 239, 190, 150)),
              waterDropColor: Color.fromARGB(255, 239, 190, 150),
            ),
            child: ListViewUsers(users: users)));
  }

  _loadUsers() async {
    await Future.delayed(const Duration(milliseconds: 1000));
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
    return ListTile(
      onTap: () {
        Navigator.pushReplacementNamed(context,'chat');
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
