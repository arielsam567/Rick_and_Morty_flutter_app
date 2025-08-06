import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ricky_and_martie_app/repositories/rickandmorty_repository.dart';

/// Exemplo de como usar o RickAndMortyRepository refatorado
/// Este arquivo demonstra como usar o repository que agora usa abstração HTTP
class RepositoryUsageExample extends StatefulWidget {
  const RepositoryUsageExample({super.key});

  @override
  State<RepositoryUsageExample> createState() => _RepositoryUsageExampleState();
}

class _RepositoryUsageExampleState extends State<RepositoryUsageExample> {
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

    try {
      // Acessando o repository através do Provider
      // Agora o repository usa abstração HTTP em vez do Dio diretamente
      final repository = context.read<RickAndMortyRepository>();

      // Buscando personagens
      final response = await repository.getCharacters();

      setState(() {
        characters = response.results;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _searchCharacter(String name) async {
    try {
      final repository = context.read<RickAndMortyRepository>();
      final response = await repository.searchCharactersByName(name);

      setState(() {
        characters = response.results;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  Future<void> _getCharacterById(int id) async {
    try {
      final repository = context.read<RickAndMortyRepository>();
      final character = await repository.getCharacterById(id);
      // Aqui você pode usar o character encontrado
      print('Personagem encontrado: ${character.name}');
    } catch (e) {
      print('Erro ao buscar personagem: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplo de Uso do Repository'),
      ),
      body: _buildBody(),
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
