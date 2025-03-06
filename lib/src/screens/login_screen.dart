import 'package:chat/constants.dart';
import 'package:chat/src/screens/create_account_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDesktop = screenWidth > 600;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: KeyboardListener(
        focusNode: _focusNode,
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 450 : screenWidth * 0.9,
                maxHeight: isDesktop ? 450 : screenHeight * 0.65,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: isDesktop ? 100 : screenWidth * 0.15,
                          maxHeight: isDesktop ? 100 : screenHeight * 0.15,
                        ),
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "Chat",
                        style: TextStyle(fontFamily: "Merienda"),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email",
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(_isObscured
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscured == false
                                    ? _isObscured = true
                                    : _isObscured = false;
                              });
                            },
                          ),
                          labelText: "Senha",
                        ),
                        obscureText: _isObscured,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/ContactScreen');
                          },
                          child: Text('Entrar'),
                        ),
                      ),
                      Text("ou"),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CreateAccountScreen()),
                            );
                          },
                          child: Text('Criar Conta'),
                        ),
                      ),
                      SizedBox(
                        child: TextButton(
                          onPressed: () {},
                          child: Text("esqueci a senha"),
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
