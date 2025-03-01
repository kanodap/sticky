// lib/app/modules/feed/views/feed_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../components/product_item.dart';
import '../../../components/screen_title.dart';
import '../../../routes/app_pages.dart';
import '../../../../utils/constants.dart';
import '../controllers/feed_controller.dart';

class FeedView extends GetView<FeedController> {
  const FeedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Feed"),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.BOOKMARK),
            icon: SvgPicture.asset(
              Constants.bookmarkIcon,
              color: Get.theme.iconTheme.color,
            ),
          ),
          IconButton(
            onPressed: () => Get.toNamed(Routes.FAVORITES),
            icon: SvgPicture.asset(
              Constants.favoritesIcon,
              color: Get.theme.iconTheme.color,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            30.verticalSpace,
            const ScreenTitle(title: 'FEED'),
            20.verticalSpace,
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = (constraints.maxWidth / 180).floor();
                if (crossAxisCount < 2) crossAxisCount = 2;
                return GetBuilder<FeedController>(
                  builder: (controller) => GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 15.w,
                      mainAxisSpacing: 15.h,
                      mainAxisExtent: 260.h,
                    ),
                    itemCount: controller.postings.length,
                    itemBuilder: (context, index) {
                      final post = controller.postings[index];
                      return Stack(
                        children: [
                          // 제품 이미지를 표시하는 위젯
                          ProductItem(product: post),
                          // 우측 상단에 북마크 버튼
                          Positioned(
                            top: 8.h,
                            right: 8.w,
                            child: GestureDetector(
                              onTap: () {
                                controller.toggleBookmark(post.id ?? 0);
                              },
                              child: Icon(
                                post.isBookmarked == true
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: Get.theme.primaryColor,
                                size: 24.sp,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
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





