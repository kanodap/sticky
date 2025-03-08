import 'dart:convert';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../config/theme/my_theme.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../routes/app_pages.dart';

class SettingsController extends GetxController {
  var isLightTheme = MySharedPref.getThemeIsLight();

  // reactive 변수로 선언
  RxString userName = ''.obs;

  @override
  void onInit() {
    loadUserData();
    super.onInit();
  }

  /// SharedPreferences에서 저장된 사용자 정보를 불러와 userName 업데이트
  Future<void> loadUserData() async {
    final userDataString = MySharedPref.getUserData();
    if (userDataString != null && userDataString.isNotEmpty) {
      final userData = jsonDecode(userDataString);
      userName.value = userData['name'] ?? '';
    } else {
      userName.value = '';
    }
    // Obx를 사용하므로 update() 호출은 필요하지 않습니다.
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.snackbar("Success", "로그아웃 성공");
      // 로그아웃 후 Base 화면(메인 화면)으로 이동 (필요하다면 로그인 화면으로 이동)
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar("Error", "로그아웃 실패: ${e.toString()}");
    }
  }

  void changeTheme(bool value) {
    MyTheme.changeTheme();
    isLightTheme = MySharedPref.getThemeIsLight();
    update(['Theme']);
  }
}

