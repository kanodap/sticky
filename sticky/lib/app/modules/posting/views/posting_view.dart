// 게시글 작성하는 UI 제공
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/screen_title.dart';
import '../controllers/posting_controller.dart';

class PostingView extends GetView<PostingController> {
  const PostingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Post"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            30.verticalSpace,
            const ScreenTitle(title: 'Posting'),
            20.verticalSpace,
            TextField(
              maxLines: 5,
              onChanged: (value) {
                controller.postContent = value;
              },
              decoration: InputDecoration(
                hintText: 'Write your post...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            20.verticalSpace,
            // 이미지 선택 버튼 (예시)
            ElevatedButton(
              onPressed: () {
                // 이미지 선택 로직 (예: 이미지 피커 호출)
              },
              child: const Text("Select Image"),
            ),
            20.verticalSpace,
            ElevatedButton(
              onPressed: () => controller.submitPost(),
              child: const Text("Submit Post"),
            ),
          ],
        ),
      ),
    );
  }
}


