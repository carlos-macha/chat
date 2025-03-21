import 'dart:convert';
import 'package:chat/src/interfaces/contact_interface.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ContactService {
  final String baseUrl = "http://192.168.0.11:3000";

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<bool> addContact(Contact contact) async {
    final url = Uri.parse("$baseUrl/addContact");
    final token = await getToken();

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(contact.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Contact>> showContact() async {
    final url = Uri.parse("$baseUrl/showContacts");
    final token = await getToken();

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> contactList = data['users'];

      List<Contact> contacts = contactList.map((element) {
        return Contact(
          email: element['email'],
          name: element['name'],
        );
      }).toList();

      return contacts;
    } else {
      throw Exception('Erro ao carregar contatos: ${response.statusCode}');
    }
  }
}
