import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  // 인스턴스 생성을 막기 위한 private 생성자
  MySharedPref._();

  static late SharedPreferences _sharedPreferences;

  // 키 정의
  static const String _fcmTokenKey = 'fcm_token';
  static const String _lightThemeKey = 'is_theme_light';
  static const String _userDataKey = 'userData';
  /// 초기화 함수
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// 테마 설정 함수들...
  static Future<void> setThemeIsLight(bool lightTheme) =>
      _sharedPreferences.setBool(_lightThemeKey, lightTheme);

  static bool getThemeIsLight() =>
      _sharedPreferences.getBool(_lightThemeKey) ?? true;

  /// FCM 토큰 함수들...
  static Future<void> setFcmToken(String token) =>
      _sharedPreferences.setString(_fcmTokenKey, token);

  static String? getFcmToken() => _sharedPreferences.getString(_fcmTokenKey);

  /// 사용자 데이터를 JSON 문자열로 저장하는 함수
  static Future<void> setUserData(String userData) =>
      _sharedPreferences.setString(_userDataKey, userData);

  /// 저장된 사용자 데이터를 불러오는 함수 (없으면 null 반환)
  static String? getUserData() => _sharedPreferences.getString(_userDataKey);

  /// 저장된 모든 데이터를 클리어하는 함수
  static Future<void> clear() async => await _sharedPreferences.clear();
}
