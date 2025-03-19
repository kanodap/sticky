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

  // 로그인한 사용자의 정보를 저장하는 Rx 변수 (null 안전하게 관리)
  Rxn<model.UserModel> user = Rxn<model.UserModel>();

  /// Firestore에서 현재 로그인한 사용자의 상세 정보를 가져옵니다.
  Future<model.UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =
    await _firestore.collection('users').doc(currentUser.uid).get();

    return model.UserModel.fromSnap(documentSnapshot);
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

        // 로그인 후 추가로 사용자 데이터를 조회할 경우 아래와 같이 호출할 수 있습니다.
        // model.User userData = await getUserDetails();
        // 예: userData.username 등 활용 가능

        // 로그인 성공 후 Base (메인 화면)으로 이동
        Get.offNamed(Routes.BASE);
      }
    } catch (e) {
      Get.snackbar("Error", "로그인 실패: ${e.toString()}");
    }
  }
}



