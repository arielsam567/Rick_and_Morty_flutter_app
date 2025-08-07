import 'package:flutter/material.dart';
import 'package:ricky_and_martie_app/widgets/character_card_shimmer.dart';

class CharacterListShimmer extends StatelessWidget {
  final int itemCount;

  const CharacterListShimmer({
    super.key,
    this.itemCount = 10,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          return _buildGridView(context, constraints);
        } else {
          return _buildListView(context);
        }
      },
    );
  }

  Widget _buildGridView(BuildContext context, BoxConstraints constraints) {
    final cardWidth = 350.0;
    final cardHeight = 120.0;
    final spacing = 8.0;

    final availableWidth = constraints.maxWidth - (spacing * 2);
    final crossAxisCount = ((availableWidth + spacing) / (cardWidth + spacing))
        .floor()
        .clamp(1, 10);

    final totalSpacing = spacing * (crossAxisCount - 1);
    final actualCardWidth = (availableWidth - totalSpacing) / crossAxisCount;

    final childAspectRatio = actualCardWidth / cardHeight;

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const CharacterCardShimmer();
      },
    );
  }

  Widget _buildListView(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const CharacterCardShimmer();
      },
    );
  }
}
