import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

/// Acts a data access object (DAO) for the managing posts in the database or as
/// data transfer object (DTO) for transferring data between screens (UI).
class Post {
  String id;
  DateTime date;
  String imageURL;
  double latitude;
  double longitude;
  int quantity;

  Post({
    required this.id,
    required this.date,
    required this.imageURL,
    required this.latitude,
    required this.longitude,
    required this.quantity,
  });

  /// Returns the date in a formatted string (e.g. "January 1, 2021")
  String get formattedDate => DateFormat.yMMMMEEEEd().format(date);

  /// Converts the post to a map for saving to the database.
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'imageURL': imageURL,
      'latitude': latitude,
      'longitude': longitude,
      'quantity': quantity,
    };
  }

  /// Converts the snapshot to a post object for accessing the data.
  Post.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        date = (doc.data()!['date'] as Timestamp).toDate(),
        imageURL = doc.data()!['imageURL'],
        latitude = doc.data()!['latitude'],
        longitude = doc.data()!['longitude'],
        quantity = doc.data()!['quantity'];
}
