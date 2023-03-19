import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/post.dart';

void main() {
  group('Post', () {
    test('toMap() returns a map with the correct keys and values', () {
      final post = Post(
        date: DateTime(2021, 1, 1),
        imageURL: 'imageURL',
        latitude: 1.0,
        longitude: 2.0,
        quantity: 3,
      );
      final map = post.toMap();
      expect(map['date'], DateTime(2021, 1, 1));
      expect(map['imageURL'], 'imageURL');
      expect(map['latitude'], 1.0);
      expect(map['longitude'], 2.0);
      expect(map['quantity'], 3);
    });

    test('fromFirestore() returns a post with the correct values', () async {
      final fakeFirestore = FakeFirebaseFirestore();
      final fakePostSnapshot = {
        'id': '123',
        'date': Timestamp.fromDate(DateTime(2021, 1, 1)),
        'imageURL': 'imageURL',
        'latitude': 1.0,
        'longitude': 2.0,
        'quantity': 3,
      };

      await fakeFirestore.collection('posts').doc('123').set(fakePostSnapshot);

      final fakeSnapshot =
          await fakeFirestore.collection('posts').doc('123').get();
      final post = Post.fromFirestore(fakeSnapshot);

      expect(post.id, '123');
      expect(post.date, DateTime(2021, 1, 1));
      expect(post.imageURL, 'imageURL');
      expect(post.latitude, 1.0);
      expect(post.longitude, 2.0);
      expect(post.quantity, 3);
    });
  });
}
