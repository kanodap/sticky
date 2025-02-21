import 'package:get/get.dart';

class FeedController extends GetxController {
  // Posting 이미지 경로 리스트 (예시 더미 데이터)
  List<String> postings = [];

  @override
  void onInit() {
    // 더미 데이터 초기화 (실제 앱에서는 API나 Posting 모듈의 데이터를 받아옵니다)
    postings = [
      'assets/images/product1.png',
      'assets/images/product2.png',
      'assets/images/product3.png',
      'assets/images/product4.png',
      'assets/images/product5.png',
      // 필요에 따라 추가...
    ];
    update();
    super.onInit();
  }
}
