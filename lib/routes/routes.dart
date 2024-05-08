import 'package:flutter/material.dart';
import 'package:realtime_chat/pages/chat_page.dart';
import 'package:realtime_chat/pages/loading_page.dart';
import 'package:realtime_chat/pages/login_page.dart';
import 'package:realtime_chat/pages/register_page.dart';
import 'package:realtime_chat/pages/users_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'user': (_) => const UsersPage(),
  'register': (_) => const RegisterPage(),
  'login': (_) => const LoginPage(),
  'loading': (_) => const LoadingPage(),
  'chat': (_) => const ChatPage(),
};
