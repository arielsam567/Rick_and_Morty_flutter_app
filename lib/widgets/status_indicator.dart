import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  final String status;
  final double dotSize;
  final TextStyle? textStyle;

  const StatusIndicator({
    required this.status,
    this.dotSize = 8.0,
    this.textStyle,
    super.key,
  });

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            color: _getStatusColor(),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          status,
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
