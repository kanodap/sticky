import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../../../routes/app_pages.dart';
import '../../../data/local/my_shared_pref.dart'; // 만약 추가 프로필 정보를 저장하고 싶다면 사용

class SignupController extends GetxController {
  String name = '';
  String email = '';
  String password = '';

  /// Firebase Auth를 사용하여 회원가입 처리
  Future<void> signup() async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "모든 필드를 입력하세요.");
      return;
    }
    try {
      // Firebase Auth로 회원가입
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final userData = jsonEncode({
        "name": name,
        "email": email,
        "uid": userCredential.user!.uid,
      });

      Get.snackbar("Success", "회원가입이 완료되었습니다.");
      // 회원가입 후 로그인 화면으로 이동 (로그인 후 Base로 이동하도록 수정 가능)
      Get.offNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar("Error", "회원가입 실패: ${e.toString()}");
    }
  }
}


