import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/models/mensajes_response.dart';
import 'package:realtime_chat/services/auth_service.dart';
import 'package:realtime_chat/services/chat_service.dart';
import 'package:realtime_chat/services/socket_service.dart';
import 'package:realtime_chat/widgets/message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  bool isWriting = false;
  List<Message> messages = [];
  @override
  void initState() {
    // TODO: implement initState
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);
    socketService.socket.on('mensaje-personal', _escucharMensaje);
    _cargarHistorial(chatService.usuarioPara.uid);
    super.initState();
  }

  void _cargarHistorial(usuarioId) async {
    List<Mensaje> chat = await chatService.getChat(usuarioId);
    print(chat);
    final history = chat.map(
      (m)=> Message(
        animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 0))..forward(),
        text: m.mensaje,
        uid: m.de,
      )
    );
    setState(() {
      //messages = chat;
      messages.insertAll(0, history);
    });
  }

  void _escucharMensaje(dynamic data) {
    print("escucharMensaje $data");
    Message message = Message(
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300)),
      text: data['mensaje'],
      uid: data['de'],
    );
    setState(() {
      messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    //final chatService = Provider.of<ChatService>(context);
    final usuarioPara = chatService.usuarioPara;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 239, 190, 150),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'user');
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  CircleAvatar(
                    maxRadius: 14,
                    backgroundColor: const Color.fromARGB(255, 73, 97, 113),
                    child: Text(
                      usuarioPara.nombre.substring(0, 2),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    usuarioPara.nombre,
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              )
            ],
          ),
          centerTitle: true,
          elevation: 4,
        ),
        body: Center(
          child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, i) => messages[i],
                itemCount: messages.length,
                reverse: true,
              )),
              const Divider(height: 1),
              Container(
                color: Colors.white,
                height: 50,
                child: Row(
                  children: [
                    Flexible(
                        child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enviar mensaje',
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      focusNode: _focusNode,
                      onChanged: (String text) {
                        setState(() {
                          if (text.trim().isNotEmpty) {
                            isWriting = true;
                          } else {
                            isWriting = false;
                          }
                        });
                      },
                      onSubmitted: _handleSubmit,
                    )),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: IconTheme(
                        data: const IconThemeData(
                            color: Color.fromARGB(255, 73, 97, 113)),
                        child: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: isWriting
                              ? () {
                                  _handleSubmit(_textController.text);
                                }
                              : null,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void _handleSubmit(String texto) {
    if (texto != '') {
      print('Mensaje enviado: ${_textController.text}');
      final newMessage = Message(
          text: texto,
          uid: authService.usuario!.uid,
          animationController: AnimationController(
              vsync: this, duration: const Duration(milliseconds: 400)));
      _textController.clear();
      _focusNode.requestFocus();
      newMessage.animationController.forward();
      setState(() {
        messages.insert(0, newMessage);
        isWriting = false;
      });
      socketService.emit('mensaje-personal', {
        "de": authService.usuario?.uid,
        "para": chatService.usuarioPara.uid,
        "mensaje": texto,
        "fecha": DateTime.now().toUtc().toString()
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for (Message message in messages) {
      message.animationController.dispose();
    }
    socketService.socket.off('mensaje-personal', _escucharMensaje);
    super.dispose();
  }
}
