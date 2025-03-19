import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/screen_title.dart';
import '../controllers/posting_controller.dart';
import 'package:image_picker/image_picker.dart';

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
            // 이미지 선택 버튼 (카메라, 갤러리 선택)
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: const Text('Select Image'),
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                            controller.selectImage(ImageSource.camera);
                            Navigator.pop(context);
                          },
                          child: const Text('Camera'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            controller.selectImage(ImageSource.gallery);
                            Navigator.pop(context);
                          },
                          child: const Text('Gallery'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Select Image"),
            ),
            20.verticalSpace,
            // 선택한 이미지 미리보기
            Obx(() {
              if (controller.imageFile.value != null) {
                return Image.memory(
                  controller.imageFile.value!,
                  height: 200,
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
            20.verticalSpace,
            // 게시글 제출 버튼 (업로드 중 로딩 인디케이터 포함)
            ElevatedButton(
              onPressed: () => controller.submitPost(),
              child: Obx(() {
                return controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Submit Post");
              }),
            ),
          ],
        ),
      ),
    );
  }
}



