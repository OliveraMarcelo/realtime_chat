import 'package:flutter/material.dart';
import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/services/auth_service.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;



  void connect() async{
    final token =await  AuthService.getToken();
    print("token : $token");
    // Dart client
    _socket = IO.io(
        'http://localhost:3000',
        {
          'transports': ['websocket'],
          'autoConnect': true,
          'forceNew': true,
          'auth': {
            'x-token': token,
          },
        });

    _socket.on('connect', (_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
    _socket.on('connect', (_) => print('Conectado al servidor'));
    _socket.on('disconnect', (_) => print('Desconectado del servidor'));
    _socket.on('connect_error', (err) => print('Error de conexión: $err'));
    _socket.on('reconnect_attempt', (_) => print('Intentando reconectar'));
  }

  void disconnect() {
    _socket.disconnect();
  }
}
