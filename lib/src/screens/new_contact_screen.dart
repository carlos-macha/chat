import 'package:chat/constants.dart';
import 'package:chat/src/interfaces/contact_interface.dart';
import 'package:chat/src/services/contact_service.dart';
import 'package:flutter/material.dart';

class NewContactScreen extends StatefulWidget {
  const NewContactScreen({super.key});

  @override
  State<NewContactScreen> createState() => _NewContactScreenState();
}

class _NewContactScreenState extends State<NewContactScreen> {
  final FocusNode _focusNode = FocusNode();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _contactService = ContactService();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newContact = Contact(
        email: _emailController.text,
      );

      bool success = await _contactService.addContact(newContact);

      if (success) {
        print("criado");
        Navigator.pushReplacementNamed(context, '/ContactScreen');
      } else {
        print("deu ruim");
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDesktop = screenWidth > 600;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Novo contato"),
      ),
      body: KeyboardListener(
        focusNode: _focusNode,
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 450 : screenWidth * 0.9,
                maxHeight: isDesktop ? 450 : screenHeight * 0.45,
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  boxShadow: [shadow],
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Email do contato"),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                         height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: Text('Adicionar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
