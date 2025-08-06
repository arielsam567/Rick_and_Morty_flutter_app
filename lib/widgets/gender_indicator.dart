import 'package:flutter/material.dart';

class GenderIndicator extends StatelessWidget {
  final String gender;
  final double iconSize;
  final Color iconColor;
  final TextStyle? textStyle;

  const GenderIndicator({
    required this.gender,
    this.iconSize = 16.0,
    this.iconColor = Colors.black54,
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          gender.toLowerCase() == 'male' ? Icons.male : Icons.female,
          size: iconSize,
          color: iconColor,
        ),
        const SizedBox(width: 4),
        Text(
          gender,
          style: textStyle ??
              const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
        ),
      ],
    );
  }
}
