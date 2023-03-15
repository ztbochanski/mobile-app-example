import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    Key? key,
    required this.title,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.child,
  }) : super(key: key);

  final String title;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: child,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
