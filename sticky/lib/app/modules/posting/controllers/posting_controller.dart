// 피드 올리는 기능의 상태 및 로직 관리
import 'package:get/get.dart';

class PostingController extends GetxController {
  // 게시글 텍스트 내용
  String postContent = '';

  // 게시글에 첨부할 이미지 경로 (선택한 이미지)
  String? imagePath;

  // 게시글 업로드 함수 (실제 API 연동 전 더미 데이터로 테스트)
  void submitPost() {
    // 게시글 내용 및 이미지를 서버로 전송하는 로직을 여기에 추가
    // 예: print("Posting: $postContent, image: $imagePath");

    // 게시글 업로드 후 피드 화면(HomeView)으로 돌아가거나 알림을 표시
    Get.snackbar('Post Submitted', 'Your post has been uploaded successfully.');
  }
}
