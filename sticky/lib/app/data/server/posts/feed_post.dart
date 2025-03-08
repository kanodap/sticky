import 'package:cloud_firestore/cloud_firestore.dart';

class FeedPostService {
  final CollectionReference _feedPosts =
  FirebaseFirestore.instance.collection('feedPosts');

  Future<void> createFeedPost({
    required String imageURL,
    required String caption,
    required String userId,
    required String userName,
  }) async {
    await _feedPosts.add({
      'imageURL': imageURL,
      'caption': caption,
      'userId': userId,
      'userName': userName,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Map<String, dynamic>>> streamFeedPosts() {
    return _feedPosts.orderBy('timestamp', descending: true).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList(),
    );
  }
}

