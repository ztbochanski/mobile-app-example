import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;
  final int quantity;

  const TitleText({required this.title, required this.quantity, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('$title - $quantity wasted items');
  }
}
