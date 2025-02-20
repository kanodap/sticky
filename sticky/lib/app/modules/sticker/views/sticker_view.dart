import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../components/screen_title.dart';
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
                // 사용자가 입력하면 검색어 업데이트
              },
              decoration: const InputDecoration(
                hintText: 'Enter sticker keyword',
                border: OutlineInputBorder(),
              ),
            ),
            10.verticalSpace,
            ElevatedButton(
              onPressed: () {
                // 예를 들어, 현재 TextField의 값을 StickerController의 searchStickers 호출
                controller.searchStickers("example");
              },
              child: const Text("Search"),
            ),
            20.verticalSpace,
            Expanded(
              child: GetBuilder<StickerController>(
                builder: (_) {
                  if (controller.isLoading) {
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
                        // 간단하게 Image.network()로 스티커 표시
                        return Image.network(controller.stickerResults[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
