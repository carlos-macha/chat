import 'package:chat/src/screens/chat_screen.dart';
import 'package:chat/src/screens/config_screen.dart';
import 'package:chat/src/screens/contact_screen.dart';
import 'package:chat/src/screens/create_account_screen.dart';
import 'package:chat/src/screens/login_screen.dart';
import 'package:chat/src/screens/new_contact_screen.dart';
import 'package:chat/src/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.light(
          primary: Color(0xFF7C4DFF),
          secondary: Color.fromARGB(255, 150, 130, 184),
          surface: Color(0xFFF3E5F5),
          onPrimary: Color(0xFFFFFFFF),
          onSurface: Color(0xFF212121),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.dark(
          primary: Color(0xFFBB86FC),
          secondary: Color.fromARGB(255, 51, 51, 51),
          surface: Color(0xFF121212),
          onPrimary: Color(0xFF000000),
          onSurface: Color(0xFFE0E0E0),
        ),
      ),
      themeMode: _themeMode,
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        "/LoginScreen": (context) => const LoginScreen(),
        "/ChatScreen": (context) => const ChatScreen(),
        "/ConfigScreen": (context) => ConfigScreen(
            isDarkMode: _themeMode == ThemeMode.dark, toggleTheme: _toggleTheme),
        "/ContactScreen": (context) => const ContactScreen(),
        "/CreateAccountScreen": (context) => const CreateAccountScreen(),
        "/NewContactScreen": (context) => const NewContactScreen(),
      },
    );
  }
}
