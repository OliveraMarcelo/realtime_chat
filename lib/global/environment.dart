import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class Environment {
  static String apiUrl = kIsWeb
      ? 'http://localhost:3000/api' 
      : Platform.isAndroid
          ? 'http://10.0.2.2:3000/api'
          : 'http://localhost:3000/api';

  static String socketUrl = kIsWeb
      ? 'http://localhost:3000/socket'
      : Platform.isAndroid
          ? 'http://10.0.2.2:3000/socket'
          : 'http://localhost:3000/socket'; 
}
