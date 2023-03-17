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

  /// Converts the post from a snapshot to a post object.
  factory Post.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final date = (data['date'] as Timestamp).toDate();
    return Post(
      id: snapshot.id,
      date: date,
      imageURL: data['imageURL'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      quantity: data['quantity'],
    );
  }

  /// Returns the date in a formatted string (e.g. "January 1, 2021")
  String get formattedDate => DateFormat.yMMMMEEEEd().format(date);
}
