import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ricky_and_martie_app/config/strings.dart';
import 'package:ricky_and_martie_app/pages/home/home_controller.dart';
import 'package:ricky_and_martie_app/widgets/error_message_widget.dart';
import 'package:ricky_and_martie_app/widgets/empty_state_widget.dart';
import 'package:ricky_and_martie_app/widgets/character_list_shimmer.dart';
import 'package:ricky_and_martie_app/widgets/responsive_character_list.dart';
import 'package:ricky_and_martie_app/widgets/search_field_widget.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SearchFieldWidget(
              onChanged: _controller.updateSearchQuery,
              onClear: () => _controller.updateSearchQuery(''),
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
                    if (_controller.emptyState) {
                      return EmptyStateWidget(
                        icon: Icons.search_off,
                        title: 'Nenhum personagem encontrado',
                        subtitle: 'Tente buscar por outro nome.',
                      );
                    }

                    return EmptyStateWidget(
                      icon: Icons.people_outline,
                      title: 'Nenhum personagem encontrado',
                      subtitle:
                          'Não foi possível carregar os personagens no momento.',
                    );
                  }

                  return ResponsiveCharacterList(
                    characters: _controller.characters,
                    scrollController: _controller.scrollController,
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
