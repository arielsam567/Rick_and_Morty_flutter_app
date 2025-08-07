import 'package:flutter/material.dart';

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
        const Divider(),
        const Text(
          'WHEREABOUTS',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        _buildLocationItem('ORIGIN', origin),
        const SizedBox(height: 8),
        _buildLocationItem('LOCATION', location),
      ],
    );
  }

  Widget _buildLocationItem(String label, String value) {
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
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
            size: 20,
          ),
        ],
      ),
    );
  }
}
