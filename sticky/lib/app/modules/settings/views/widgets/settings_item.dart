import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants.dart';
import '../../controllers/settings_controller.dart';
import '../../../../routes/app_pages.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isAccount;
  final bool isDark;
  final VoidCallback? onTap; // 추가: 외부에서 onTap을 지정할 수도 있음

  const SettingsItem({
    Key? key,
    required this.title,
    required this.icon,
    this.isAccount = false,
    this.isDark = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ListTile(
      onTap: isAccount
          ? () {
        if (title == 'Login') {
          Get.toNamed(Routes.LOGIN);
        } else if (title == 'Sign Out') {
          // 'settings' 태그로 등록된 SettingsController 인스턴스를 가져와 로그아웃 처리
          final settingsController =
          Get.find<SettingsController>();
          settingsController.logout();
        } else {
          // 로그인되어 있고, title이 "Login"이나 "Sign Out"이 아니면 프로필 페이지로 이동
          Get.toNamed(Routes.FAVORITES);
        }
      }
          : onTap,
      title: Text(
        title,
        style: theme.textTheme.displayMedium?.copyWith(
          fontSize: 16.sp,
        ),
      ),
      leading: CircleAvatar(
        radius: isAccount ? 30.r : 30.r,
        backgroundColor: theme.primaryColor,
        child: SvgPicture.asset(icon, fit: BoxFit.none),
      ),
      trailing: isDark
          ? GetBuilder<SettingsController>(
        id: 'Theme',
        builder: (controller) => CupertinoSwitch(
          value: !controller.isLightTheme,
          onChanged: controller.changeTheme,
          activeColor: theme.primaryColor,
        ),
      )
          : (!isAccount
          ? Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: SvgPicture.asset(
          Constants.forwardArrowIcon,
          fit: BoxFit.none,
        ),
      )
          : null),
    );
  }
}
