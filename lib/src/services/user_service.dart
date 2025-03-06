import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:chat/src/interfaces/user_interface.dart';


class UserService {
  final String baseUrl = "http://192.168.0.11:3000/api";
  //final String baseUrl = "http://localhost:3000/api";

  // Método para criar um novo usuário
  Future<bool> createUser(User user) async {
    final url = Uri.parse('$baseUrl/users');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return true; // Usuário criado com sucesso
    } else {
      print('Erro ao criar usuário: ${response.body}');
      return false;
    }
  }
}