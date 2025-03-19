import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/app/data/models/post_model.dart';
import 'package:ecommerce_app/app/modules/login/controllers/login_controller.dart';
import 'package:ecommerce_app/app/modules/posting/controllers/posting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      decoration: BoxDecoration(
        border: Border.all(
          color: width > 600 ? Colors.grey[300]! : Colors.white,
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // HEADER SECTION
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(post['profImage']),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    post['username'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                if (post['uid'] == authController.user.value?.uid)
                  IconButton(
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
                    icon: const Icon(Icons.more_vert),
                  ),
              ],
            ),
          ),
          // IMAGE SECTION
          GestureDetector(
            onDoubleTap: () {
              postController.likePost(post['postId'], authController.user.value?.uid ?? '', post['likes']);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  post['postUrl'],
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Obx(() => LikeAnimation(
                  isAnimating: isLikeAnimating.value,
                  duration: const Duration(milliseconds: 400),
                  onEnd: () => isLikeAnimating.value = false,
                  child: const Icon(Icons.favorite, color: Colors.white, size: 100),
                )),
              ],
            ),
          ),
          // LIKE & BOOKMARK SECTION
          Row(
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
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          // DESCRIPTION
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${post['likes'].length} likes',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w800),
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
                  DateFormat.yMMMd()
                      .format(post['datePublished'].toDate()),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
