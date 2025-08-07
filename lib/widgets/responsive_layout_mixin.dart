import 'package:flutter/material.dart';

mixin ResponsiveLayoutMixin {
  static const double breakpoint = 700.0;
  static const double cardWidth = 350.0;
  static const double cardHeight = 120.0;
  static const double spacing = 8.0;

  bool isLargeScreen(BoxConstraints constraints) {
    return constraints.maxWidth > breakpoint;
  }

  int calculateCrossAxisCount(BoxConstraints constraints) {
    final availableWidth = constraints.maxWidth - (spacing * 2);
    return ((availableWidth + spacing) / (cardWidth + spacing))
        .floor()
        .clamp(1, 10);
  }

  double calculateChildAspectRatio(BoxConstraints constraints) {
    final crossAxisCount = calculateCrossAxisCount(constraints);
    final totalSpacing = spacing * (crossAxisCount - 1);
    final availableWidth = constraints.maxWidth - (spacing * 2);
    final actualCardWidth = (availableWidth - totalSpacing) / crossAxisCount;
    return actualCardWidth / cardHeight;
  }

  SliverGridDelegateWithFixedCrossAxisCount createGridDelegate(
      BoxConstraints constraints) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: calculateCrossAxisCount(constraints),
      childAspectRatio: calculateChildAspectRatio(constraints),
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
    );
  }
}
