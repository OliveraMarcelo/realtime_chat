import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class Environment {
  static String apiUrl = kIsWeb
      ? 'https://realtime-chat-backend-zf7p.onrender.com/api' 
      : Platform.isAndroid
          ? 'http://10.0.2.2:3000/api'
          : 'https://realtime-chat-backend-zf7p.onrender.com/api';

  static String socketUrl = kIsWeb
      ? 'https://realtime-chat-backend-zf7p.onrender.com/socket'
      : Platform.isAndroid
          ? 'http://10.0.2.2:3000/socket'
          : 'https://realtime-chat-backend-zf7p.onrender.com/socket'; 
}
