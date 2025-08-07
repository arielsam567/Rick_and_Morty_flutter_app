import 'package:flutter/material.dart';
import 'package:ricky_and_martie_app/models/character.dart';
import 'package:ricky_and_martie_app/widgets/character_card.dart';
import 'package:ricky_and_martie_app/widgets/responsive_layout_mixin.dart';

class ResponsiveCharacterList extends StatelessWidget
    with ResponsiveLayoutMixin {
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
        if (isLargeScreen(constraints)) {
          return _buildGridView(context, constraints);
        } else {
          return _buildListView(context);
        }
      },
    );
  }

  Widget _buildGridView(BuildContext context, BoxConstraints constraints) {
    return GridView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(8.0),
      gridDelegate: createGridDelegate(constraints),
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return CharacterCard(character: character);
      },
    );
  }

  Widget _buildListView(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(8.0),
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return CharacterCard(character: character);
      },
    );
  }
}
