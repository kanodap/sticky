import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  String email = '';
  String password = '';

  /// Firebase Auth를 사용하여 로그인 처리
  Future<void> login() async {
    try {
      // 이메일/비밀번호로 로그인 시도
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // 로그인 성공 여부 확인
      if (userCredential.user != null) {
        Get.snackbar("Success", "로그인 성공");
        // 로그인 성공 후 Base (메인 화면)으로 이동
        Get.offNamed(Routes.BASE);
      }
    } catch (e) {
      Get.snackbar("Error", "로그인 실패: ${e.toString()}");
    }
  }
}


