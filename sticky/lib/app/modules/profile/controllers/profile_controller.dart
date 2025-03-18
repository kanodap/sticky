import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String name = "";
  String email = "";
  String phone = "";
  String address = "";
  List<String> interests = [];

  @override
  void onInit() {
    super.onInit();
    loadUserInfo();
  }

  // 사용자 정보 가져오기
  Future<void> loadUserInfo() async {
    String uid = _auth.currentUser!.uid;
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();

    if (userDoc.exists) {
      var data = userDoc.data() as Map<String, dynamic>;
      name = data['name'] ?? '';
      email = data['email'] ?? '';
      phone = data['phone'] ?? '';
      address = data['address'] ?? '';
      interests = List<String>.from(data['interests'] ?? []);

      update(); // UI 갱신
    }
  }

  // 사용자 정보 업데이트
  Future<void> updateUserInfo({String? newPhone, String? newAddress, List<String>? newInterests}) async {
    String uid = _auth.currentUser!.uid;

    await _firestore.collection('users').doc(uid).update({
      if (newPhone != null) 'phone': newPhone,
      if (newAddress != null) 'address': newAddress,
      if (newInterests != null) 'interests': newInterests,
    });

    loadUserInfo();
  }
}

