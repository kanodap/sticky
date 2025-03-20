import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../utils/constants.dart';
import '../../../login/controllers/login_controller.dart';
import '../../controllers/posting_controller.dart';
import 'like_animation.dart';

class PostCard extends StatelessWidget {
  final Map<String, dynamic> post;
  PostCard({Key? key, required this.post}) : super(key: key);

  final LoginController authController = Get.find<LoginController>();
  final PostingController postController = Get.find<PostingController>();
  final RxBool isLikeAnimating = false.obs;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8), // 위아래 간격 추가
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), // 모서리 둥글게
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 3), // 아래쪽 그림자
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // 📌 HEADER SECTION (프로필, 이름, 더보기 버튼)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    print('프로필 클릭: ${post['username']}'); // 디버깅용
                    // 여기에 프로필 페이지로 이동하는 기능 추가 가능
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(post['profImage']),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      print('이름 클릭: ${post['username']}'); // 디버깅용
                    },
                    child: Text(
                      post['username'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                Obx(() {
                  print('현재 로그인 유저 UID: ${authController.user.value?.uid}'); // 디버깅용
                  print('게시글 UID: ${post['uid']}'); // 디버깅용

                  return post['uid'] == authController.user.value?.uid
                      ? IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Delete Post",
                        middleText: "Are you sure you want to delete this post?",
                        textConfirm: "Yes",
                        textCancel: "No",
                        onConfirm: () {
                          postController.deletePost(post['postId']);
                          Get.back();
                        },
                      );
                    },
                  )
                      : const SizedBox(); // UID 불일치 시 빈 공간
                }),
              ],
            ),
          ),

          // 📌 IMAGE SECTION
          GestureDetector(
            onDoubleTap: () {
              postController.likePost(post['postId'], authController.user.value?.uid ?? '', post['likes']);
              isLikeAnimating.value = true;
              },
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12), // 이미지 모서리 둥글게
                  child: post['postUrl'] != null && post['postUrl'].toString().isNotEmpty
                      ? Image.network(
                    post['postUrl'],
                    width: double.infinity,
                    fit: BoxFit.fitWidth, // 비율 유지하면서 가로 크기 맞춤
                  )
                      : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.scaleDown, // 원본 비율 유지하면서 화면에 맞춤
                      child: Image.asset(Constants.product1),
                    ),
                  ),
                ),

                // isLikeAnmating 살짝 허접
                Obx(() {
                  return isLikeAnimating.value
                      ? LikeAnimation(
                    isAnimating: isLikeAnimating.value,
                    duration: const Duration(milliseconds: 400),
                    onEnd: () => isLikeAnimating.value = false,
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 100,
                    ),
                  )
                      : const SizedBox(); // 💡 기본 상태에서는 표시되지 않음
                }),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // 📌 LIKE, COMMENT, SHARE, BOOKMARK ICONS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Obx(() => LikeAnimation(
                  isAnimating: post['likes'].contains(authController.user.value?.uid ?? ''),
                  smallLike: true,
                  child: IconButton(
                    icon: post['likes'].contains(authController.user.value?.uid ?? '')
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : const Icon(Icons.favorite_border),
                    onPressed: () {
                      postController.likePost(post['postId'], authController.user.value?.uid ?? '', post['likes']);
                    },
                  ),
                )),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {},
                ),
                const Spacer(), // 📌 오른쪽 정렬을 위해 Spacer 사용
                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // 📌 DESCRIPTION & DATE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${post['likes'].length} likes',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: post['username'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' ${post['description']}'),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat.yMMMd().format(post['datePublished'].toDate()),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

