import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/constants.dart';
import '../../../components/screen_title.dart';
import '../controllers/settings_controller.dart';
import 'widgets/settings_item.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            SizedBox(height: 30.h),
            const ScreenTitle(title: 'SETTINGS', dividerEndIndent: 230),
            SizedBox(height: 20.h),
            Text(
              'Account',
              style: theme.textTheme.displayMedium?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 20.h),
            // Obx를 사용해 controller.userName이 변경될 때마다 자동 업데이트
            Obx(() {
              final displayName = controller.userName.value.isNotEmpty
                  ? controller.userName.value
                  : 'Login';
              return SettingsItem(
                title: displayName,
                icon: Constants.userIcon,
                isAccount: true,
              );
            }),
            SizedBox(height: 30.h),
            Text(
              'Settings',
              style: theme.textTheme.displayMedium?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 20.h),
            const SettingsItem(
              title: 'Dark Mode',
              icon: Constants.themeIcon,
              isDark: true,
            ),
            SizedBox(height: 25.h),
            SettingsItem(
              title: 'Help',
              icon: Constants.helpIcon,
              onTap: () {
                Get.defaultDialog(
                  title: 'Contact Email',
                  content: Text(
                    'toma12345@naver.com',
                    style: TextStyle(fontSize: 10.sp),
                  ),
                  confirm: ElevatedButton(
                    onPressed: () => Get.back(),
                    child: const Text("Close"),
                  ),
                );
              },
            ),
            SizedBox(height: 25.h),
            const SettingsItem(
              title: 'Sign Out',
              icon: Constants.logoutIcon,
              isAccount: true,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

