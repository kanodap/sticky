import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/product_item.dart';
import '../../../components/screen_title.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Optional: AppBar 추가해서 상단 알림 아이콘 등도 넣을 수 있음
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            30.verticalSpace,
            const ScreenTitle(
              title: 'STCKY',
            ),
            20.verticalSpace,
            // LayoutBuilder를 사용하여 화면 크기에 맞게 그리드 열 개수를 동적으로 변경
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
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) => ProductItem(
                    product: controller.products[index],
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

