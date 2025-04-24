

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter IDE')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /*    ElevatedButton.icon(
              icon: const Icon(Icons.code),
              label: const Text('Editor de Código'),
              onPressed: () => Navigator.pushNamed(context, '/editor'),
            ),
            const SizedBox(height: 16), */
            ElevatedButton.icon(
              icon: const Icon(Icons.terminal),
              label: const Text('Terminal'),
              onPressed: () => Navigator.pushNamed(context, '/terminal'),
            ),
          ],
        ),
      ),
    );
  }
}