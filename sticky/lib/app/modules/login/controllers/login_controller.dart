import 'dart:convert';
import 'package:get/get.dart';

import '../../../data/local/my_shared_pref.dart';
import '../../../routes/app_pages.dart';
import '../../settings/controllers/settings_controller.dart';

class LoginController extends GetxController {
  String email = '';
  String password = '';

  Future<void> login() async {
    // MySharedPref를 통해 저장된 사용자 데이터를 가져옵니다.
    final userDataString = MySharedPref.getUserData();
    if (userDataString == null) {
      Get.snackbar("Error", "회원가입 정보가 없습니다.");
      return;
    }
    final userData = jsonDecode(userDataString);
    if (userData['email'] == email && userData['password'] == password) {
      Get.snackbar("Success", "로그인 성공");
      // 로그인 성공 후 SettingsController의 데이터를 다시 불러옴
      Get.find<SettingsController>().loadUserData();
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.offNamed(Routes.BASE);
      });
    } else {
      Get.snackbar("Error", "잘못된 이메일 또는 비밀번호");
    }
  }
}

