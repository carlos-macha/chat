import 'package:chat/constants.dart';
import 'package:chat/src/interfaces/user_interface.dart';
import 'package:chat/src/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '../services/user_service.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final UserService _userService = UserService();
  bool _isObscured = true;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text == _passwordConfirmController.text) {
        final newUser = User(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );

        bool success = await _userService.createUser(newUser);

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Usuário criado com sucesso!')),
          );
          _nameController.clear();
          _emailController.clear();
          _passwordController.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao criar usuário')),
          );
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
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
        title: Text(
          "Criar conta",
          style: TextStyle(fontFamily: "Merienda"),
        ),
      ),
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
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Nome",
                        ),
                      ),
                      TextFormField(
                        controller: _passwordController,
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
                      TextFormField(
                        controller: _passwordConfirmController,
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
                          labelText: "Repetir Senha",
                        ),
                        obscureText: _isObscured,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: Text('Criar Conta'),
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
