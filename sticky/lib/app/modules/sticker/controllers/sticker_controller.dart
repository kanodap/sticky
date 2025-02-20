// 스티커 검색 로직 및 상태관리, ex) 사용자의 검색어, 검색 결과 리스트, 로딩상태 등
import 'package:get/get.dart';

class StickerController extends GetxController {
  // 검색어
  String searchQuery = '';

  // 검색 결과를 담을 리스트 (실제 API 연동 시 모델을 활용)
  List<String> stickerResults = []; // 예시: 스티커 이미지 URL 리스트

  // 로딩 상태 등 추가적인 상태 관리도 가능
  bool isLoading = false;

  // 검색 함수 (API 호출이나 더미 데이터 활용)
  void searchStickers(String query) {
    searchQuery = query;
    isLoading = true;
    update();

    // 예시: 간단한 더미 데이터 사용
    Future.delayed(const Duration(seconds: 1), () {
      stickerResults = List.generate(10, (index) => 'https://example.com/sticker_$index.png');
      isLoading = false;
      update();
    });
  }
}
