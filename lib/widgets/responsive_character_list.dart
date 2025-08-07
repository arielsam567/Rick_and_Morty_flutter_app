import 'package:flutter/material.dart';
import 'package:ricky_and_martie_app/models/character.dart';
import 'package:ricky_and_martie_app/widgets/character_card.dart';
import 'package:ricky_and_martie_app/widgets/loading_more_widget.dart';

class ResponsiveCharacterList extends StatelessWidget {
  final List<Character> characters;
  final ScrollController scrollController;
  final bool hasMorePages;
  final VoidCallback? onLoadMore;

  const ResponsiveCharacterList({
    required this.characters,
    required this.scrollController,
    required this.hasMorePages,
    this.onLoadMore,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          // Layout para telas grandes (desktop/tablet)
          return _buildGridView(context, constraints);
        } else {
          // Layout para telas pequenas (mobile)
          return _buildListView(context);
        }
      },
    );
  }

  Widget _buildGridView(BuildContext context, BoxConstraints constraints) {
    // Calcula quantas colunas cabem na tela
    final crossAxisCount =
        (constraints.maxWidth / 358).floor(); // 350 + 8 spacing

    return GridView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: MediaQuery.of(context).size.width / 358,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: characters.length + (hasMorePages ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == characters.length) {
          return const LoadingMoreWidget();
        }

        final character = characters[index];
        return CharacterCard(character: character);
      },
    );
  }

  Widget _buildListView(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(8.0),
      itemCount: characters.length + (hasMorePages ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == characters.length) {
          return const LoadingMoreWidget();
        }

        final character = characters[index];
        return CharacterCard(character: character);
      },
    );
  }
}
