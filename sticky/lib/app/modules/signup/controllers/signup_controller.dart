import 'dart:convert';
import 'package:get/get.dart';

import '../../../data/local/my_shared_pref.dart';

class SignupController extends GetxController {
  String name = '';
  String email = '';
  String password = '';

  Future<void> signup() async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "모든 필드를 입력하세요.");
      return;
    }

    // JSON 형식으로 사용자 정보 저장
    final userData = jsonEncode({
      "name": name,
      "email": email,
      "password": password,
    });
    // MySharedPref에 저장 (예를 들어, 'userData'라는 키로 저장)
    await MySharedPref.setUserData(userData);

    Get.snackbar("Success", "회원가입이 완료되었습니다.");
    Get.offNamed('/login');
  }
}

