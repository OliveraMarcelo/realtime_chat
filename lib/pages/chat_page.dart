import 'package:flutter/material.dart';
import 'package:realtime_chat/widgets/message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool isWriting = false;
  List<Message> messages = [];
  @override
  Widget build(BuildContext context) {
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
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  CircleAvatar(
                    maxRadius: 14,
                    backgroundColor: Color.fromARGB(255, 73, 97, 113),
                    child: Text(
                      'LJ',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    'Jhuly Lopez',
                    style: TextStyle(fontSize: 12),
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
          uid: '1',
          animationController: AnimationController(
              vsync: this, duration: const Duration(milliseconds: 400)));
      _textController.clear();
      _focusNode.requestFocus();
      newMessage.animationController.forward();
      setState(() {
        messages.insert(0, newMessage);
        isWriting = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for (Message message in messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
