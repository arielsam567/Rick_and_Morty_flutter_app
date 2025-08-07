import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ricky_and_martie_app/config/strings.dart';
import 'package:ricky_and_martie_app/pages/home/home_controller.dart';
import 'package:ricky_and_martie_app/widgets/character_card.dart';
import 'package:ricky_and_martie_app/widgets/error_message_widget.dart';
import 'package:ricky_and_martie_app/widgets/empty_state_widget.dart';
import 'package:ricky_and_martie_app/widgets/character_list_shimmer.dart';
import 'package:ricky_and_martie_app/widgets/loading_more_widget.dart';
import 'package:ricky_and_martie_app/widgets/responsive_character_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController _controller;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = HomeController(context.read());
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _controller.loadCharacters();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (_controller.hasMorePages && !_controller.isLoadingMore) {
        _controller.loadMoreCharacters();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: 600,
              ),
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
                    // Se está em modo de busca e não encontrou nada
                    if (_controller.isSearchMode &&
                        _controller.searchQuery.isNotEmpty) {
                      return EmptyStateWidget(
                        icon: Icons.search_off,
                        title: 'Nenhum personagem encontrado',
                        subtitle: 'Tente buscar por outro nome.',
                      );
                    }

                    // Se não está em busca e não há personagens
                    return EmptyStateWidget(
                      icon: Icons.people_outline,
                      title: 'Nenhum personagem encontrado',
                      subtitle:
                          'Não foi possível carregar os personagens no momento.',
                    );
                  }

                  return ResponsiveCharacterList(
                    characters: _controller.characters,
                    scrollController: _scrollController,
                    hasMorePages: _controller.hasMorePages,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
