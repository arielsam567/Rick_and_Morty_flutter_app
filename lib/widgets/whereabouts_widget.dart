import 'package:flutter/material.dart';
import 'package:ricky_and_martie_app/widgets/section_header.dart';
import 'package:ricky_and_martie_app/widgets/property_item.dart';

class WhereaboutsWidget extends StatelessWidget {
  final String origin;
  final String location;

  const WhereaboutsWidget({
    required this.origin,
    required this.location,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: 'WHEREABOUTS'),
        const SizedBox(height: 16),
        PropertyRow(label: 'ORIGIN', value: origin),
        const SizedBox(height: 8),
        PropertyRow(label: 'LOCATION', value: location),
      ],
    );
  }
}
