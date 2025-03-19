import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/sticker_controller.dart';

class StickerView extends GetView<StickerController> {
  const StickerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sticker Search"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            20.verticalSpace,
            TextField(
              onChanged: (value) {
                controller.searchStickers(value);
              },
              decoration: const InputDecoration(
                hintText: 'Enter sticker keyword',
                border: OutlineInputBorder(),
              ),
            ),
            10.verticalSpace,
            ElevatedButton(
              onPressed: () {
                controller.searchStickers("example"); // Replace with actual input value
              },
              child: const Text("Search"),
            ),
            20.verticalSpace,
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.stickerResults.isEmpty) {
                  return const Center(child: Text("No stickers found."));
                } else {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                    ),
                    itemCount: controller.stickerResults.length,
                    itemBuilder: (context, index) {
                      return Image.network(controller.stickerResults[index]);
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

