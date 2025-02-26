import 'dart:convert';
import 'package:get/get.dart';
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
    final userDataString = MySharedPref.getUserData();
    if (userDataString != null && userDataString.isNotEmpty) {
      final userData = jsonDecode(userDataString);
      userData['isLoggedIn'] = false;
      await MySharedPref.setUserData(jsonEncode(userData));
    }
    // 로그인 상태 초기화: userName을 빈 문자열로 만들어 "Login"으로 보이게 함
    userName.value = '';
    //Get.offAllNamed(Routes.BASE);
  }

  void changeTheme(bool value) {
    MyTheme.changeTheme();
    isLightTheme = MySharedPref.getThemeIsLight();
    update(['Theme']);
  }
}

