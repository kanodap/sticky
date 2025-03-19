import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../data/models/user_model.dart';

class SignupController extends GetxController {
  String name = '';
  String email = '';
  String password = '';

  /// Firebase Auth를 사용하여 회원가입 처리 및 Firestore에 사용자 데이터 저장
  Future<void> signup() async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "모든 필드를 입력하세요.");
      return;
    }
    try {
      // Firebase Auth를 이용한 회원가입
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // User 객체 생성 (필요에 따라 기본값을 설정)
      final newUser = UserModel(
        username: name, // name을 username으로 사용
        uid: userCredential.user!.uid,
        email: email,
        photoUrl: "https://example.com/default_profile.png", // 기본 프로필 사진 URL (수정 가능)
        bio: "", // 초기 bio는 빈 문자열
        followers: [],
        following: [],
      );

      // Firestore에 사용자 데이터 저장
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(newUser.toJson());

      Get.snackbar("Success", "회원가입이 완료되었습니다.");
      // 회원가입 후 로그인 화면으로 이동 (또는 Base 화면으로 변경 가능)
      Get.offNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar("Error", "회원가입 실패: ${e.toString()}");
    }
  }
}


