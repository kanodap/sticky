import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../components/product_item.dart';
import '../../../components/screen_title.dart';
import '../../../routes/app_pages.dart';
import '../../../../utils/constants.dart';
import '../controllers/feed_controller.dart';

/*
class FeedView extends GetView<FeedController> {
  const FeedView({Key? key}) : super(key: key);
*/

class FeedView extends StatefulWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  _FeedViewState createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  late FeedController controller;

  @override
  void initState() {
    super.initState();
    // 만약 FeedController가 등록되어 있지 않으면 직접 등록
    if (!Get.isRegistered<FeedController>()) {
      controller = Get.put(FeedController());
    } else {
      controller = Get.find<FeedController>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar에 Favorites와 Bookmark 버튼 추가
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Feed"),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.BOOKMARK),
            icon: SvgPicture.asset(
              Constants.bookmarkIcon, // Constants.bookmarkIcon은 constants.dart에 정의
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
            const ScreenTitle(
              title: 'FEED',
            ),
            20.verticalSpace,
            LayoutBuilder(
              builder: (context, constraints) {
                // 원하는 최소 아이템 너비를 예: 180로 설정
                int crossAxisCount = (constraints.maxWidth / 180).floor();
                if (crossAxisCount < 2) crossAxisCount = 2;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 15.h,
                    mainAxisExtent: 260.h,
                  ),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: controller.postings.length,
                  itemBuilder: (context, index) => ProductItem(
                    product: controller.postings[index],
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

