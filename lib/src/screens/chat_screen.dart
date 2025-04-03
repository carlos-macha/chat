import 'package:chat/src/interfaces/message_interface.dart';
import 'package:chat/src/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  final MessageService _messageService = MessageService();
  final ScrollController _scrollController = ScrollController();
  List<Widget> messagesList = [];
  final AudioRecorder audioRecorder = AudioRecorder();

    @override
  void initState() {
    super.initState();
    _messageController.addListener(_updateIcon);
  }

  @override
  void dispose() {
    _messageController.removeListener(_updateIcon);
    super.dispose();
  }

    void _updateIcon() {
    setState(() {});
  }

  Future<void> sendMessage(String contactEmail) async {
    if (_formKey.currentState!.validate()) {
      final newMessage = Message(
        content: _messageController.text,
        contactEmail: contactEmail
      );

    bool sucess = await _messageService.sendMessage(newMessage);

    if(sucess) {
      print("message sent");
    } else {
      print("message not sent");
    }

    }
  }

  void messageBox(BuildContext context) {
    final contactEmail = ModalRoute.of(context)!.settings.arguments as String;
    final screenWidth = MediaQuery.of(context).size.width;
    final String messageText = _messageController.text.trim();
 
    try {
      sendMessage(contactEmail);

      setState(() {
        if (messageText.isNotEmpty) {
          messagesList.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenWidth * 0.8,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        messageText,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      });
    } catch (error) {
      print(error);
    }

    _messageController.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              color: Theme.of(context).colorScheme.secondary,
              offset: Offset(0, 50),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: "op1",
                  child: Text("Dados do contato"),
                ),
                PopupMenuItem(
                  value: "op2",
                  child: Text("Apagar mensagens"),
                ),
                PopupMenuItem(
                  value: "op3",
                  child: Text("Bloquear"),
                ),
              ],
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text("contato"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: false,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: messagesList[index],
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 3,
                    controller: _messageController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(_messageController.text.trim().isEmpty
                            ? Icons.mic
                            : Icons.send),
                        onPressed: () => messageBox(context),
                      ),
                      labelText: "Mensagem",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
