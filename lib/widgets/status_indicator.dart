import 'package:flutter/material.dart';
import 'package:ricky_and_martie_app/models/character.dart';

class StatusIndicator extends StatelessWidget {
  final Character character;
  final double dotSize = 6;

  const StatusIndicator({
    required this.character,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            color: character.getStatusColor(),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          character.status.name,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
