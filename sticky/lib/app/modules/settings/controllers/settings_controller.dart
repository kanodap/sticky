import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../config/theme/my_theme.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../routes/app_pages.dart';

class SettingsController extends GetxController {
  // RxBool로 관리하여 UI가 즉시 반영되도록 변경
  RxBool isLightTheme = MySharedPref.getThemeIsLight().obs;

  Rx<User?> currentUser = FirebaseAuth.instance.currentUser.obs;

  @override
  void onInit() {
    super.onInit();
    _listenAuthChanges();
  }

  void _listenAuthChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      currentUser.value = user;
      update(['Account']);
    });
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.snackbar("Success", "로그아웃 성공");
      //Get.offAllNamed(Routes.SETTINGS);
    } catch (e) {
      Get.snackbar("Error", "로그아웃 실패: ${e.toString()}");
    }
  }

  /// 테마 변경 함수
  void changeTheme(bool value) async {
    isLightTheme.value = value; // ✅ RxBool 값 먼저 변경하여 즉시 UI 반영
    await MySharedPref.setThemeIsLight(value); // ✅ SharedPreferences 저장 (UI 업데이트 방해 X)
  }
}




