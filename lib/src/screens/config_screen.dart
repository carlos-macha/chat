import 'package:flutter/material.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen(
      {super.key, required this.toggleTheme, required this.isDarkMode});
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Configurações"),
      ),
      body: Expanded(
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          child: ListView(
            children: [
              ListTile(
                leading: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
                subtitle: Text(widget.isDarkMode ? "escuro" : "claro"),
                title: Text('Tema'),
                trailing: ElevatedButton.icon(
                  onPressed:
                      widget.toggleTheme,
                  icon: Icon(
                      widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                  label: Text(widget.isDarkMode ? 'Modo Claro' : 'Modo Escuro'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
