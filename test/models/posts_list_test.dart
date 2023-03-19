import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/models/posts_list.dart';

Future<AsyncSnapshot<QuerySnapshot<Object?>>> getFakeSnapshot() async {
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

  final QuerySnapshot<Object?> fakeSnapshot =
      await fakeFirestore.collection('posts').get();

  return AsyncSnapshot<QuerySnapshot<Object?>>.withData(
      ConnectionState.done, fakeSnapshot);
}

void main() {
  group('Post list', () {
    test('Has a list of posts', () {
      final postsList = PostsList([]);
      expect(postsList.posts, []);
    });

    test('Can create a post list from a Firestore query snapshot', () async {
      final fakeSnapshot = await getFakeSnapshot();

      final postsList = PostsList.fromFirestore(fakeSnapshot);

      expect(postsList.posts.length, 1);
      expect(postsList.posts[0].id, '123');
      expect(postsList.posts[0].date, DateTime(2021, 1, 1));
      expect(postsList.posts[0].imageURL, 'imageURL');
      expect(postsList.posts[0].latitude, 1.0);
      expect(postsList.posts[0].longitude, 2.0);
      expect(postsList.posts[0].quantity, 3);
    });

    test('Can check empty', () {
      final postsList = PostsList([]);
      expect(postsList.isEmpty(), true);
    });

    test('Can get length', () {
      final postsList = PostsList([]);
      expect(postsList.length(), 0);
    });

    test('Can sort descending', () {
      final postsList = PostsList([
        Post(
          date: DateTime(2021, 1, 1),
          imageURL: 'imageURL',
          latitude: 1.0,
          longitude: 2.0,
          quantity: 3,
        ),
        Post(
          date: DateTime(2021, 1, 2),
          imageURL: 'imageURL',
          latitude: 1.0,
          longitude: 2.0,
          quantity: 3,
        ),
      ]);
      postsList.descendingSort();
      expect(postsList.posts[0].date, DateTime(2021, 1, 2));
      expect(postsList.posts[1].date, DateTime(2021, 1, 1));
    });
  });
}
