import 'package:flutter/material.dart';
import 'package:ricky_and_martie_app/widgets/empty_state_widget.dart';

class EmptyCharactersWidget extends StatelessWidget {
  final bool isEmptyState;

  const EmptyCharactersWidget({
    required this.isEmptyState, super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isEmptyState) {
      return const EmptyStateWidget(
        icon: Icons.search_off,
        title: 'Nenhum personagem encontrado',
        subtitle: 'Tente buscar por outro nome.',
      );
    }

    return const EmptyStateWidget(
      icon: Icons.people_outline,
      title: 'Nenhum personagem encontrado',
      subtitle: 'Não foi possível carregar os personagens no momento.',
    );
  }
}
