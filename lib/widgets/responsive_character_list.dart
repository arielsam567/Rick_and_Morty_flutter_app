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
    final cardWidth = 350.0;
    final spacing = 8.0;
    final availableWidth = constraints.maxWidth - (spacing * 2);
    final cardsPerRow = ((availableWidth + spacing) / (cardWidth + spacing))
        .floor()
        .clamp(1, 10);

    // Calcula quantas linhas teremos
    final totalItems = characters.length + (hasMorePages ? 1 : 0);
    final rowCount = (totalItems / cardsPerRow).ceil();

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(8.0),
      itemCount: rowCount,
      itemBuilder: (context, rowIndex) {
        final startIndex = rowIndex * cardsPerRow;
        final endIndex = (startIndex + cardsPerRow).clamp(0, totalItems);

        final rowItems = <Widget>[];

        for (int i = startIndex; i < endIndex; i++) {
          if (i == characters.length) {
            // Loading widget
            rowItems.add(
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 350),
                  child: const LoadingMoreWidget(),
                ),
              ),
            );
          } else if (i < characters.length) {
            final character = characters[i];
            rowItems.add(
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 350),
                  child: CharacterCard(character: character),
                ),
              ),
            );
          }
        }

        // Adiciona espaços vazios se necessário para manter alinhamento
        while (rowItems.length < cardsPerRow) {
          rowItems.add(const Expanded(child: SizedBox()));
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowItems,
          ),
        );
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
