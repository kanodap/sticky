import 'package:get/get.dart';

class LoginController extends GetxController {
  // 로그인에 필요한 변수
  String email = '';
  String password = '';

  // 간단한 로그인 로직 (실제 구현은 필요에 따라 수정)
  void login() {
    // 예시: 콘솔에 로그인 정보를 출력 후 이전 화면으로 돌아감
    print("Logging in with email: $email, password: $password");
    // 로그인 성공 후 Home이나 원하는 화면으로 이동하도록 구현 가능
    Get.back();
  }
}
