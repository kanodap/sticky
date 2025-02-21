import 'package:get/get.dart';

class SearchController extends GetxController {
  // 예시로 표시할 텍스트를 관리하는 변수
  String featureText = "This is New Feature";

  // 필요한 비즈니스 로직 함수들을 작성합니다.
  void updateText(String newText) {
    featureText = newText;
    update(); // GetX의 update()를 호출해 UI를 갱신합니다.
  }
}
