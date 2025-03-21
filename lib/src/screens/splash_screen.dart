import 'package:chat/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authService = AuthService();

  @override
  void initState() {
    Future.delayed(Duration.zero, checkLoginStatus);
    super.initState();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');
    print(token);

    if (token != null && token.isNotEmpty) {
      print("deu bom!!");
      bool isValid = await _authService.validateToken(token);
      print(isValid);
      isValid
          ? Navigator.pushReplacementNamed(context, '/ContactScreen')
          : Navigator.pushReplacementNamed(context, '/LoginScreen');
      print("sim");
    } else {
      Navigator.pushReplacementNamed(context, '/LoginScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
