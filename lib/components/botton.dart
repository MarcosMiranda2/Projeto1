import 'package:flutter/material.dart';

class Botton extends StatelessWidget {
  const Botton({Key? key, required this.text, required this.onPressed})
      : super();

  final String text;
  final dynamic onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('$text'),
      onPressed: () => onPressed(),
    );
  }
}
