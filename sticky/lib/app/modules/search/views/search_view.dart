import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/search_controller.dart' as mySearch;

class SearchView extends GetView<mySearch.SearchController> {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Feature"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<mySearch.SearchController>(
              builder: (controller) => Text(
                controller.featureText,
                style: TextStyle(fontSize: 24.sp),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                // 버튼 누르면 텍스트 변경 예시
                controller.updateText("New Feature Updated!");
              },
              child: const Text("Update Text"),
            ),
          ],
        ),
      ),
    );
  }
}
