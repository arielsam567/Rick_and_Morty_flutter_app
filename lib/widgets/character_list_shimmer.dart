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
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const CharacterCardShimmer();
      },
    );
  }
}
