import 'package:flutter/material.dart';
import 'package:wasteagram/models/post.dart';

class DetailScreen extends StatelessWidget {
  final Post post;
  const DetailScreen({required this.post, Key? key}) : super(key: key);

  static const routeName = '/list_detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(post.formattedDate.toString()),
          SizedBox(
            height: 350,
            width: 600,
            child: Image.network(
              '${post.imageURL}/${post.quantity}',
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
          Text('Quantity: ${post.quantity.toString()}'),
          Text('Latitude: ${post.latitude.toString()}'),
          Text('Longitude: ${post.longitude.toString()}'),
        ],
      ),
    );
  }
}
