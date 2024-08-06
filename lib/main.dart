import 'package:flutter/material.dart';
import 'package:simple_calculator/calculator.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 183, 32, 32),
        body: Column(
          children: [
            Expanded(
              child: Calculator(),
            ),
          ],
        ),
      ),
    ),
  );
}
