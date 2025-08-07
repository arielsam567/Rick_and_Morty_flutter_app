import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final double spacing = 10;

  const SectionHeader({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double dividerWidth = screenWidth < 400 ? 50 : 100;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: dividerWidth,
          child: const Divider(),
        ),
        SizedBox(width: spacing),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
        SizedBox(width: spacing),
        SizedBox(
          width: dividerWidth,
          child: const Divider(),
        ),
      ],
    );
  }
}
