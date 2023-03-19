import 'package:flutter/material.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/services/firestore_service.dart';

class NewPostForm extends StatefulWidget {
  final String url;

  const NewPostForm({required this.url, Key? key}) : super(key: key);

  @override
  State<NewPostForm> createState() => _NewPostFormState();
}

class _NewPostFormState extends State<NewPostForm> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _firestoreService = FirestoreService.getInstance();

  final Post post = Post();

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: Image.network(
                widget.url,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            TextFormField(
              controller: _quantityController,
              decoration: const InputDecoration(
                hintText: 'Number of items',
              ),
              onSaved: (value) {
                post.quantity = int.parse(value!);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a number';
                } else if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  post.imageURL = widget.url;
                  _firestoreService.uploadPost(post);
                  Navigator.pop(context, _quantityController.text);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
