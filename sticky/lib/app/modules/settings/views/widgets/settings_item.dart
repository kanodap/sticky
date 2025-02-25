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
  const SettingsItem({
    Key? key,
    required this.title,
    required this.icon,
    this.isAccount = false,
    this.isDark = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ListTile(
      onTap: isAccount
          ? () {
        // 만약 제목이 "Login"이면 로그인 화면으로, 그렇지 않으면 Profile(마이페이지)로 이동
        if (title == 'Login') {
          Get.toNamed(Routes.LOGIN);
        } else {
          Get.toNamed(Routes.FAVORITES);
        }
      }
          : null,
      title: Text(
        title,
        style: theme.textTheme.displayMedium?.copyWith(
          fontSize: 16.sp,
        ),
      ),
      /*subtitle: !isAccount
          ? null
          : Text(
        '+218 92 00 000 00',
        style: theme.textTheme.displaySmall,
      ),*/
      leading: CircleAvatar(
        radius: isAccount ? 30.r : 25.r,
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
          : isAccount
          ? GestureDetector(
        onTap: () => Get.toNamed(Routes.LOGIN),
        child: Container(
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
        ),
      )
          : Container(
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
      ),
    );
  }
}
