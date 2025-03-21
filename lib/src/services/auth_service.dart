import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:chat/src/interfaces/user_interface.dart';

class AuthService {
  final String baseUrl = "http://192.168.0.11:3000";

  Future<String?> login(User user) async {
    final url = Uri.parse("$baseUrl/login");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['token']; // Retorna o token se o login for bem-sucedido
      } else {
        print('Erro ao logar: ${response.body}');
        return null;
      }
    } catch (error) {
      return error.toString();
    }
  }

   Future<bool> createUser(User user) async {
    final url = Uri.parse('$baseUrl/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      print('Erro ao criar usuário: ${response.body}');
      return false;
    }
  }

  Future<bool> validateToken(String token) async {
    final url = Uri.parse("$baseUrl/validate");

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        print("ok");
        return true;
      }
    } catch (error) {
      print(error);
    }
    return false;
  }
}
