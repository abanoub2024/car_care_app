import 'package:flutter/material.dart';

class ConsumableCard extends StatelessWidget {
  final String name;
  final double percentage;
  final int remainingKm;

  String get status {
    if (percentage >= 0.9 || remainingKm <= 500) {
      return 'Urgent';
    } else if (percentage >= 0.8) {
      return 'Due Soon';
    } else {
      return 'Good';
    }
  }

  const ConsumableCard({
    super.key,
    required this.name,
    required this.percentage,
    required this.remainingKm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            '${(percentage * 100).toInt()}% Used',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: percentage,
            minHeight: 10,
          ),
          const SizedBox(height: 15),
          Text(
            '$remainingKm KM Remaining',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Status: $status',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}