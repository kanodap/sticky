import 'dart:convert';

import 'package:get/get.dart';
import '../../../../config/theme/my_theme.dart';
import '../../../data/local/my_shared_pref.dart';

class SettingsController extends GetxController {
  var isLightTheme = MySharedPref.getThemeIsLight();

  // 사용자 이름 저장 변수
  String userName = '';

  @override
  void onInit() {
    loadUserData();
    super.onInit();
  }

  /// SharedPreferences에서 사용자 정보를 불러오는 함수
  Future<void> loadUserData() async {
    // 비동기적으로 저장된 userData를 불러오기
    final userDataString = MySharedPref.getUserData();
    if (userDataString != null && userDataString.isNotEmpty) {
      final userData = jsonDecode(userDataString);
      userName = userData['name'] ?? '';
    } else {
      userName = '';
    }
    update(['Account']); // 데이터 로드 후 화면 갱신
  }
  /// 테마 변경 함수
  changeTheme(bool value) {
    MyTheme.changeTheme();
    isLightTheme = MySharedPref.getThemeIsLight();
    update(['Theme']);
  }
}
