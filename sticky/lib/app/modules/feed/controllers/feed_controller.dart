import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data/models/post_model.dart'; // Post 클래스 import

class FeedController extends GetxController {
  List<PostModel> postings = [];

  @override
  void onInit() {
    getPostings();
    super.onInit();
  }

  void getPostings() async {
    try {
      // Firestore에서 posts 컬렉션의 데이터를 가져옵니다.
      QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('posts').get();

      // 가져온 데이터를 Post 객체 리스트로 변환
      postings = snapshot.docs.map((doc) => PostModel.fromSnap(doc)).toList();

      // UI 업데이트
      update();
    } catch (e) {
      // 에러 처리
      print('Error loading posts: $e');
    }
  }

}


