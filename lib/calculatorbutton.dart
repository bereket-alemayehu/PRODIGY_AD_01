import 'package:flutter/material.dart';

class Calculatorbutton extends StatelessWidget {
  const Calculatorbutton(
      {super.key, required this.text, required this.onPressed});
  final String text;
  final Function(String) onPressed;

  @override
  Widget build(context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(231, 238, 238, 232),
        textStyle: const TextStyle(fontSize: 30),
        minimumSize: const Size(70, 70),
      ),
      onPressed: () {
        onPressed(text);
      },
      child: Text(
        text,
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      ),
    );
  }
}
