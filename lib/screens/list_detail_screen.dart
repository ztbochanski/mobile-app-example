import 'package:flutter/material.dart';

class ListDetailScreen extends StatelessWidget {
  const ListDetailScreen({Key? key}) : super(key: key);

  static const routeName = '/list_detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Detail'),
      ),
      body: const Center(
        child: Text('List Detail'),
      ),
    );
  }
}
