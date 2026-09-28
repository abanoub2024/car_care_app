import 'package:flutter/material.dart';
import '../widgets/consumable_card.dart';
import 'documents_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Care'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'Hyundai Elantra',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '2020 • 1.6L',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  'Current Odometer',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '125,430 KM',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),

                ConsumableCard(
                  name: '🛢️ Engine Oil',
                  percentage: 0.8,
                  remainingKm: 2000,
                ),

                SizedBox(height: 20),

                ConsumableCard(
                  name: '🔧 Brake Pads',
                  percentage: 0.5,
                  remainingKm: 15000,
                ),

                SizedBox(height: 20),

                ConsumableCard(
                  name: '🌬️ Air Filter',
                  percentage: 0.7,
                  remainingKm: 6000,
                ),
                const SizedBox(height: 30),

ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DocumentsScreen(),
      ),
    );
  },
  child: const Text('Documents & Reminders'),
),
              ],
            ),
          ),
        ],
      ),
    );
  }
}