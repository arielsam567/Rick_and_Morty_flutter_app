import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ricky_and_martie_app/config/strings.dart';
import 'package:ricky_and_martie_app/models/character.dart';
import 'package:ricky_and_martie_app/repositories/rickandmorty_repository.dart';
import 'package:ricky_and_martie_app/widgets/character_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Character> characters = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final repository = context.read<RickAndMortyRepository>();
    final result = await repository.getCharacters();

    result.fold(
      (error) {
        setState(() {
          errorMessage = error;
          isLoading = false;
        });
      },
      (response) {
        setState(() {
          characters = response.results;
          isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _buildBody(),
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

  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Erro ao carregar personagens',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(errorMessage!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadCharacters,
              child: Text('Tentar Novamente'),
            ),
          ],
        ),
      );
    }

    if (characters.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum personagem encontrado',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // childAspectRatio: 0.9,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return CharacterCard(character: character);
      },
    );
  }
}
