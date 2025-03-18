import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';
import '../../../routes/app_pages.dart';
import '../views/widgets/profile_item.dart';


class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PROFILE")),
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("NAME: ${controller.name}", style: TextStyle(fontSize: 25)),
                const SizedBox(height: 20),

                Text("E-MAIL: ${controller.email}", style: TextStyle(fontSize: 25)),
                const SizedBox(height: 20),

                ListTile(
                  title: Text("TELEPHONE: ${controller.phone.isEmpty ? '설정 필요' : controller.phone}"),
                  trailing: Icon(Icons.edit),
                  onTap: () => showEditDialog(context, "전화번호", (value) {
                    controller.updateUserInfo(newPhone: value);
                  }),
                ),
                ListTile(
                  title: Text("ADDRESS: ${controller.address.isEmpty ? '설정 필요' : controller.address}"),
                  trailing: Icon(Icons.edit),
                  onTap: () => showEditDialog(context, "주소", (value) {
                    controller.updateUserInfo(newAddress: value);
                  }),
                ),
                ListTile(
                  title: Text("STICKER"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => showEditDialog(context, "SELECT", (value) {
                    controller.updateUserInfo(newInterests: value.split(","));
                  }),
                ),
                ListTile(
                  title: Text("CART"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // 찜 목록 화면으로 이동
                    Get.toNamed(Routes.CART);
                  },
                ),
                ListTile(
                  title: Text("FAVORITE"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // 찜 목록 화면으로 이동
                    Get.toNamed(Routes.FAVORITES);
                  },
                ),
                ListTile(
                  title: Text("BOOKMARK"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // 북마크 목록 화면으로 이동
                    Get.toNamed(Routes.BOOKMARK);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

