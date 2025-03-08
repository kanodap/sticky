import 'package:cloud_firestore/cloud_firestore.dart';

class InteractionService {
  // 예시: 게시글에 좋아요 토글
  Future<void> toggleLike(String postId, String userId) async {
    DocumentReference likeRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userId);
    DocumentSnapshot doc = await likeRef.get();
    if (doc.exists) {
      await likeRef.delete();
    } else {
      await likeRef.set({'likedAt': FieldValue.serverTimestamp()});
    }
  }

  // 예시: 북마크 토글
  Future<void> toggleBookmark(String postId, String userId) async {
    DocumentReference bookmarkRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('bookmarks')
        .doc(postId);
    DocumentSnapshot doc = await bookmarkRef.get();
    if (doc.exists) {
      await bookmarkRef.delete();
    } else {
      await bookmarkRef.set({'bookmarkedAt': FieldValue.serverTimestamp()});
    }
  }
}

