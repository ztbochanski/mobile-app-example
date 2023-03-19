import 'package:flutter/material.dart';

class NewPostFAB extends StatelessWidget {
  const NewPostFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: () {
          print('New post button pressed');
        });
  }
}
