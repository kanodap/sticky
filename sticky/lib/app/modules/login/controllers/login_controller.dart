import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../data/models/user_model.dart' as model;
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String email = '';
  String password = '';

  // 로그인한 사용자의 정보를 저장하는 Rx 변수
  Rxn<model.UserModel> user = Rxn<model.UserModel>();

  @override
  void onInit() {
    super.onInit();
    _loadCurrentUser(); // 앱 실행 시 로그인된 사용자 정보 불러오기
  }

  /// Firestore에서 현재 로그인한 사용자의 상세 정보를 가져옵니다.
  Future<model.UserModel?> getUserDetails() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return null; // 로그인된 유저가 없으면 null 반환

    DocumentSnapshot documentSnapshot =
    await _firestore.collection('users').doc(currentUser.uid).get();

    if (!documentSnapshot.exists) return null; // 문서가 없을 경우 예외 처리

    return model.UserModel.fromSnap(documentSnapshot);
  }

  /// 현재 로그인한 사용자 정보를 불러와 user 변수에 저장
  Future<void> _loadCurrentUser() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      user.value = await getUserDetails();
      print("현재 로그인한 유저: ${user.value?.uid ?? 'unknown'}");
    }
  }

  /// Firebase Auth를 사용하여 로그인 처리
  Future<void> login() async {
    try {
      // 이메일/비밀번호로 로그인 시도
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // 로그인 성공 여부 확인
      if (userCredential.user != null) {
        Get.snackbar("Success", "로그인 성공");

        // 로그인한 사용자 정보 Firestore에서 가져와서 user 변수에 저장
        user.value = await getUserDetails();
        print("로그인 후 유저 정보: ${user.value?.uid ?? 'unknown'}");

        // 로그인 성공 후 Base (메인 화면)으로 이동
        Get.offNamed(Routes.BASE);
      }
    } catch (e) {
      Get.snackbar("Error", "로그인 실패: ${e.toString()}");
    }
  }
}



