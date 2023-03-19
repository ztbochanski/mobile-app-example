import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'package:wasteagram/services/image_picker_service.dart';

class NewPostFAB extends StatefulWidget {
  const NewPostFAB({super.key});

  @override
  State<NewPostFAB> createState() => _NewPostFABState();
}

class _NewPostFABState extends State<NewPostFAB> {
  final ImagePickerService _pickerService = ImagePickerService.getInstance();
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Add post button',
      button: true,
      enabled: true,
      onTapHint: 'Add a new post photo',
      child: FloatingActionButton(
        onPressed: () async {
          final File file = await _pickerService.pickImageFromGallery();
          if (!mounted) return;
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return NewPostScreen(file: file);
          }));
        },
        tooltip: 'Add a new post photo',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
