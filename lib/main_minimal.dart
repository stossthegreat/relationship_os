import 'package:flutter/material.dart';

void main() {
  runApp(const MinimalTestApp());
}

class MinimalTestApp extends StatelessWidget {
  const MinimalTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                size: 80,
                color: Colors.pink,
              ),
              SizedBox(height: 20),
              Text(
                'RelationshipOS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'App is running!',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

