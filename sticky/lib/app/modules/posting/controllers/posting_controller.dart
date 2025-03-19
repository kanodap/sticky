import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../utils/utils.dart';
import '../../../data/models/post_model.dart';
import '../../login/controllers/login_controller.dart';

class PostingController extends GetxController {
  // 게시글 내용 (caption)
  String postContent = '';

  // Firestore 인스턴스
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 선택한 이미지 파일 (Uint8List)
  Rxn<Uint8List> imageFile = Rxn<Uint8List>();

  // 로딩 상태 관리
  var isLoading = false.obs;

  /// 이미지 선택 메서드 (카메라 또는 갤러리)
  Future<void> selectImage(ImageSource source) async {
    try {
      Uint8List? file = await pickImage(source);
      if (file != null) {
        imageFile.value = file;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  /// 선택한 이미지 초기화
  void clearImage() {
    imageFile.value = null;
  }

  /// 게시글 삭제
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  } // 이건 profile 보내야 하나..?

  /// 게시글 업로드 함수 (이 파일 내에서 구현)
  Future<String> uploadPost(String description, Uint8List? file, String uid,
      String username, String profImage) async {
    String res = "Some error occurred";
    try {
      // StorageMethods를 통해 이미지 업로드 후 URL 받아오기, firebaseStorage 유료화로 인한 무기한 정지..
      String photoUrl =  "";
      //await StorageMethods().uploadImageToStorage('posts', file, true);

      // Uuid를 사용하여 고유 postId 생성
      String postId = const Uuid().v1();

      // PostModel 객체 생성 (likes는 빈 리스트)
      PostModel post = PostModel(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
      );

      // Firestore에 게시글 데이터 저장
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .set(post.toJson());

      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  /// 게시글 업로드 메서드
  Future<void> submitPost() async {
    if (postContent.isEmpty) {
      Get.snackbar('Error', 'Please enter a caption.');
      return;
    } else{
      print("Post content: &postContent");
    }
    isLoading.value = true;
    // 현재 사용자 정보를 UserProvider에서 가져온다고 가정 (uid, username, photoUrl 포함)
    final loginController = Get.find<LoginController>();
    final currentUser = await loginController.getUserDetails();
    try {
      String res = await uploadPost(
        postContent,
        imageFile.value, // imageFile이 null이어도 처리 가능하도록 수정
        currentUser.uid,
        currentUser.username,
        currentUser.photoUrl,
      );
      if (res == "success") {
        Get.snackbar('Success', 'Your post has been uploaded successfully.');
        clearImage();
        postContent = '';
      } else {
        Get.snackbar('Error', res);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    isLoading.value = false;
  }


  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

}

