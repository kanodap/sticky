import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../utils/constants.dart';
import '../../../components/screen_title.dart';
import '../controllers/settings_controller.dart';
import '../../../routes/app_pages.dart';
import 'widgets/settings_item.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final controller = Get.find<SettingsController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
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

            const SettingsItem(
              title: 'Login',
              icon: Constants.userIcon,
              isAccount: true,
            ),
            SizedBox(height: 30.h),

            Text(
              'Settings',
              style: theme.textTheme.displayMedium?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 20.h),

            Obx(() => SettingsItem(
              title: 'Dark Mode',
              icon: Constants.themeIcon,
              isDark: true,
              switchValue: !controller.isLightTheme.value,
              onSwitchChanged: (value) {
                controller.changeTheme(value);
              },
            )),

            SizedBox(height: 25.h),

            SettingsItem(
              title: 'Help',
              icon: Constants.helpIcon,
              onTap: () => Get.dialog(
                AlertDialog(
                  title: const Text('Contact Email'),
                  content: const Text('toma12345@naver.com'),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("Close"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25.h),

            SettingsItem(
              title: 'Sign Out',
              icon: Constants.logoutIcon,
              isAccount: false,
              onTap: controller.logout,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}







