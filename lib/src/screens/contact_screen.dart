import 'package:chat/constants.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final FocusNode _focusNode = FocusNode();
  final List<Widget> contactList = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDesktop = screenWidth > 600;

    void contact() {
      setState(() {
        contactList.add(
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/ChatScreen');
            },
            child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: Theme.of(context).colorScheme.onSurface),
              ),
              child: Row(
                children: [
                  Text("Carlos"),
                ],
              ),
            ),
          ),
        );
      });
    }

    return SafeArea(
      child: Scaffold(
        body: KeyboardListener(
          focusNode: _focusNode,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 450 : screenWidth * 1,
                maxHeight: isDesktop ? 450 : screenHeight * 1,
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  boxShadow: [shadow],
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Conversas",
                          style: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        Container(
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.add,
                                  size: 40,
                                ),
                                onPressed: contact,
                              ),
                              PopupMenuButton(
                                icon: Icon(Icons.more_vert),
                                offset: Offset(0, 50),
                                color: Theme.of(context).colorScheme.secondary,
                                itemBuilder: (BuildContext context) => [
                                  PopupMenuItem(
                                    value: "op1",
                                    child: Text("Perfil"),
                                  ),
                                  PopupMenuItem(
                                    value: "op2",
                                    child: Text("Configuração"),
                                    onTap: () {
                                      Navigator.pushNamed(context, '/ConfigScreen');
                                    },
                                  ),
                                  PopupMenuItem(
                                    value: "op3",
                                    child: Text("Novo Grupo"),
                                  ),
                                  PopupMenuItem(
                                    value: "op4",
                                    child: Text(
                                      "Sair",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onTap: () {
                                      Navigator.pushReplacementNamed(context, '/');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        labelText: "Pesquisar",
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
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        child: ListView.builder(
                          itemCount:
                              contactList.isEmpty ? 1 : contactList.length,
                          itemBuilder: (context, index) {
                            return contactList.isEmpty
                                ? Center(
                                    child: Text("Adicione contatos"),
                                  )
                                : contactList[index];
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
