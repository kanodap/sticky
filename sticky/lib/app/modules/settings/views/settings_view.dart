import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../components/screen_title.dart';
import '../controllers/settings_controller.dart';
import 'widgets/settings_item.dart';
import '../../../data/local/my_shared_pref.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            30.verticalSpace,
            const ScreenTitle(
              title: 'Settings',
              dividerEndIndent: 230,
            ),
            20.verticalSpace,
            Text(
              'Account',
              style: theme.textTheme.displayMedium?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
              )
            ),
            SizedBox(height: 20.h),
            GetBuilder<SettingsController>(
              id: 'Account',
              builder: (controller) {
                // 로그인되어 있으면 사용자의 이름, 아니면 "Login" 표시
                final displayName = controller.userName.isNotEmpty
                    ? controller.userName 
                    : 'Login';
                return SettingsItem(
                  title: displayName,
                  icon: Constants.userIcon,
                  isAccount: true,
                );
              },
            ),
            30.verticalSpace,
            Text(
              'Settings',
              style: theme.textTheme.displayMedium?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
              )
            ),
            20.verticalSpace,
            const SettingsItem(
              title: 'Dark Mode',
              icon: Constants.themeIcon,
              isDark: true,
            ),
            25.verticalSpace,
            const SettingsItem(
              title: 'Help',
              icon: Constants.helpIcon,
            ),
            25.verticalSpace,
            const SettingsItem(
              title: 'Sign Out',
              icon: Constants.logoutIcon,
              isAccount: true,
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
