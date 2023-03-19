import 'package:flutter/material.dart';

class NewPostFAB extends StatelessWidget {
  const NewPostFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Add post button',
      button: true,
      enabled: true,
      onTapHint: 'Add a new post photo',
      child: FloatingActionButton(
        onPressed: () async {
          final image = await ImagePicker.pickImage(source: ImageSource.camera);
          // if (image != null) {
          //   Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) => NewPostScreen(image: image)));
          // }
          print(image);
        },
        tooltip: 'Add a new post photo',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
