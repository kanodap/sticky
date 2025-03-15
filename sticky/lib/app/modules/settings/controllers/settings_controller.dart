import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../config/theme/my_theme.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../routes/app_pages.dart';

class SettingsController extends GetxController {
  RxBool isLightTheme = MySharedPref
      .getThemeIsLight()
      .obs;

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
    print("Before change: isLightTheme = ${isLightTheme.value}");

    isLightTheme.value = !value;

    print("After change: isLightTheme = ${isLightTheme.value}");

    await MySharedPref.setThemeIsLight(!value);
    print("Saved theme: ${MySharedPref.getThemeIsLight()}");
    update();
  }
}




