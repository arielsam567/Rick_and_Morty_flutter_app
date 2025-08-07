import 'package:flutter/material.dart';
import 'package:ricky_and_martie_app/widgets/section_header.dart';
import 'package:ricky_and_martie_app/widgets/property_row.dart';

class PropertiesWidget extends StatelessWidget {
  final String gender;
  final String species;
  final String status;

  const PropertiesWidget({
    required this.gender,
    required this.species,
    required this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        const SectionHeader(title: 'PROPERTIES'),
        const SizedBox(height: 16),
        PropertyRow(label: 'GENDER', value: gender),
        const SizedBox(height: 8),
        PropertyRow(label: 'SPECIES', value: species),
        const SizedBox(height: 8),
        PropertyRow(label: 'STATUS', value: status),
      ],
    );
  }
}
