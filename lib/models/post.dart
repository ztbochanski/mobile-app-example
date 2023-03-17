import 'dart:ffi';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

/// Acts a data access object (DAO) for the managing posts in the database or as
/// data transfer object (DTO) for transferring data between screens (UI).
class Post {
  final String id;
  final String date;
  final String imageURL;
  final String latitude;
  final String longitude;
  final String quantity;

  Post({
    required this.id,
    required this.date,
    required this.imageURL,
    required this.latitude,
    required this.longitude,
    required this.quantity,
  });

  Post.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        date = DateFormat('EEEE, MMMM d, yyyy')
            .format(doc.data()!['date'].toDate()),
        imageURL = doc.data()!['imageURL'],
        latitude = doc.data()!['latitude'].toString(),
        longitude = doc.data()!['longitude'].toString(),
        quantity = doc.data()!['quantity'].toString();
}
