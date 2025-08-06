import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ricky_and_martie_app/repositories/rickandmorty_repository.dart';

/// Exemplo simples de como usar o RickAndMortyRepository
class SimpleUsageExample extends StatefulWidget {
  const SimpleUsageExample({super.key});

  @override
  State<SimpleUsageExample> createState() => _SimpleUsageExampleState();
}

class _SimpleUsageExampleState extends State<SimpleUsageExample> {
  List<dynamic> characters = [];
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

  Future<void> _searchCharacter(String name) async {
    final repository = context.read<RickAndMortyRepository>();
    final result = await repository.searchCharactersByName(name);

    result.fold(
      (error) {
        setState(() {
          errorMessage = error;
        });
      },
      (response) {
        setState(() {
          characters = response.results;
        });
      },
    );
  }

  Future<void> _getCharacterById(int id) async {
    final repository = context.read<RickAndMortyRepository>();
    final result = await repository.getCharacterById(id);

    result.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      },
      (character) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Personagem: ${character.name}')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplo Simples'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Erro: $errorMessage'),
            ElevatedButton(
              onPressed: _loadCharacters,
              child: const Text('Tentar Novamente'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Buscar personagem',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: _searchCharacter,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _getCharacterById(1),
                child: const Text('Buscar ID 1'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final character = characters[index];
              return ListTile(
                title: Text(character.name ?? 'Nome não disponível'),
                subtitle: Text(character.species ?? 'Espécie não disponível'),
                leading: character.image != null
                    ? Image.network(
                        character.image,
                        width: 50,
                        height: 50,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.person);
                        },
                      )
                    : const Icon(Icons.person),
              );
            },
          ),
        ),
      ],
    );
  }
}
