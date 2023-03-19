import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wasteagram/services/storage_service.dart';
import 'package:wasteagram/widgets/new_post_form.dart';

class NewPostScreen extends StatefulWidget {
  final File file;

  const NewPostScreen({required this.file, Key? key}) : super(key: key);

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  String url = '';
  final StorageService _storageService = StorageService.getInstance();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getImage();
    });
  }

  void getImage() async {
    final String url = await _storageService.uploadImage(widget.file);
    if (!mounted) return;
    setState(() {
      this.url = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Scaffold(
          appBar: AppBar(title: const Text('New Post')),
          body: const Center(
            child: CircularProgressIndicator(),
          ));
    } else {
      return NewPostForm(url: url);
    }
  }
}
