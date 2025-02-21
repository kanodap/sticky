import 'package:get/get.dart';

class BookmarkController extends GetxController {
  // 북마크된 게시글(예시: 이미지 자산 경로)을 저장하는 리스트
  List<String> bookmarkedPosts = [];

  @override
  void onInit() {
    // 예시 더미 데이터: 실제 애플리케이션에서는 API나 로컬 저장소에서 데이터를 불러옵니다.
    bookmarkedPosts = [
      'assets/images/product1.png',
      'assets/images/product3.png',
    ];
    super.onInit();
  }

  // 북마크 추가 함수
  void addBookmark(String post) {
    if (!bookmarkedPosts.contains(post)) {
      bookmarkedPosts.add(post);
      update(); // 상태 변경 후 UI 갱신
    }
  }

  // 북마크 삭제 함수
  void removeBookmark(String post) {
    bookmarkedPosts.remove(post);
    update();
  }
}
