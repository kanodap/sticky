import 'package:cloud_firestore/cloud_firestore.dart';

class SellingPostService {
  final CollectionReference _sellingPosts =
  FirebaseFirestore.instance.collection('sellingPosts');

  Future<void> createSellingPost({
    required String imageURL,
    required String caption,
    required int quantity,
    required double price,
    required String category,
  }) async {
    await _sellingPosts.add({
      'imageURL': imageURL,
      'caption': caption,
      'quantity': quantity,
      'price': price,
      'category': category,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // 판매글 불러오기 (실시간 업데이트 등)
  Stream<List<Map<String, dynamic>>> streamSellingPosts() {
    return _sellingPosts.orderBy('timestamp', descending: true).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList(),
    );
  }
}

