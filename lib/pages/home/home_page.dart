import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ricky_and_martie_app/config/strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bem-vindo ao Ricky and Martie!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Esta é a página inicial do aplicativo',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar para a página de detalhes
          context.go('/details');
        },
        tooltip: 'Ver Detalhes',
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
