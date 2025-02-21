import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/screen_title.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            30.verticalSpace,
            const ScreenTitle(title: 'BOOKMARKS'),
            20.verticalSpace,
            GetBuilder<BookmarkController>(
              builder: (_) {
                if (controller.bookmarkedPosts.isEmpty) {
                  return const Center(child: Text("No bookmarks found."));
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (MediaQuery.of(context).size.width / 180).floor(),
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 15.h,
                    mainAxisExtent: 260.h,
                  ),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: controller.bookmarkedPosts.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      controller.bookmarkedPosts[index],
                      fit: BoxFit.cover,
                    );
                  },
                );
              },
            ),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }
}
