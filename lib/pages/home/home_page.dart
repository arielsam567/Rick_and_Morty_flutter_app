import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ricky_and_martie_app/config/strings.dart';
import 'package:ricky_and_martie_app/pages/home/home_controller.dart';
import 'package:ricky_and_martie_app/widgets/character_card.dart';
import 'package:ricky_and_martie_app/widgets/error_message_widget.dart';
import 'package:ricky_and_martie_app/widgets/empty_state_widget.dart';
import 'package:ricky_and_martie_app/widgets/character_list_shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController(context.read());
    _controller.loadCharacters();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _controller.updateSearchQuery,
              decoration: InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          Expanded(
            child: ListenableBuilder(
              listenable: _controller,
              builder: (context, child) {
                if (_controller.isLoading) {
                  return const CharacterListShimmer();
                }

                if (_controller.errorMessage != null) {
                  return ErrorMessageWidget(
                    icon: Icons.error_outline,
                    title: 'Erro ao carregar personagens',
                    message: _controller.errorMessage,
                    onRetry: _controller.retry,
                  );
                }

                if (_controller.characters.isEmpty) {
                  return EmptyStateWidget(
                    icon: Icons.search_off,
                    title: _controller.searchQuery.isEmpty
                        ? 'Nenhum personagem encontrado'
                        : 'Nenhum personagem encontrado para "${_controller.searchQuery}"',
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: _controller.characters.length,
                  itemBuilder: (context, index) {
                    final character = _controller.characters[index];
                    return CharacterCard(character: character);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
