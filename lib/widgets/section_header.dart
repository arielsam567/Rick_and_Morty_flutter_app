import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final double dividerWidth;
  final double spacing;
  final TextStyle? titleStyle;

  const SectionHeader({
    required this.title,
    this.dividerWidth = 100,
    this.spacing = 10,
    this.titleStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          style: titleStyle ??
              const TextStyle(
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
