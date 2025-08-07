import 'package:flutter/material.dart';

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
        const Divider(),
        const Text(
          'PROPERTIES',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        _buildPropertyItem('GENDER', gender),
        const SizedBox(height: 8),
        _buildPropertyItem('SPECIES', species),
        const SizedBox(height: 8),
        _buildPropertyItem('STATUS', status),
      ],
    );
  }

  Widget _buildPropertyItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
