import 'package:flutter/material.dart';
import 'package:ricky_and_martie_app/widgets/character_card_shimmer.dart';
import 'package:ricky_and_martie_app/widgets/responsive_layout_mixin.dart';

class CharacterListShimmer extends StatelessWidget with ResponsiveLayoutMixin {
  final int itemCount;

  const CharacterListShimmer({
    super.key,
    this.itemCount = 10,
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
      padding: const EdgeInsets.all(8.0),
      gridDelegate: createGridDelegate(constraints),
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
