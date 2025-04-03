import 'package:chat/src/interfaces/message_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MessageService {
    final String baseUrl = "http://192.168.0.11:3000";

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<bool> sendMessage(Message message) async {
    final url = Uri.parse("$baseUrl/sendMessage");
    final token = await getToken();
    print(message.toJson().toString());

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(message.toJson()),
    );
    
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}