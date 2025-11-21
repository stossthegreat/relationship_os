import 'package:flutter/material.dart';

class SparkTab extends StatelessWidget {
  const SparkTab({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('=== SPARK TAB: build (simplified version) ===');
    return const Scaffold(
      backgroundColor: Color(0xFF030712),
      body: Center(
        child: Text(
          'Spark Tab Test',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
