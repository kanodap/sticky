import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../utils/constants.dart';
import '../../controllers/settings_controller.dart';
import '../../../../routes/app_pages.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isAccount;
  final bool isDark;
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final VoidCallback? onTap;

  const SettingsItem({
    Key? key,
    required this.title,
    required this.icon,
    this.isAccount = false,
    this.isDark = false,
    this.switchValue,
    this.onSwitchChanged,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final controller = Get.find<SettingsController>();

    if (isAccount) {
      return Obx(() {
        final user = controller.currentUser.value;
        final displayName = user?.displayName ?? user?.email ?? "Login";
        final avatarLetter = (user?.displayName ?? user?.email ?? "L")
            .substring(0, 1)
            .toUpperCase();
        return ListTile(
          onTap: () {
            if (user == null) {
              Get.toNamed(Routes.LOGIN);
            } else {
              Get.toNamed(Routes.FAVORITES);
            }
          },
          title: Text(
            displayName,
            style: theme.textTheme.displayMedium?.copyWith(fontSize: 16.sp),
          ),
          leading: CircleAvatar(
            radius: 30.r,
            backgroundColor: theme.primaryColor,
            child: Text(
              avatarLetter,
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
            ),
          ),
          trailing: isDark
              ? Obx(() => CupertinoSwitch(
            value: !controller.isLightTheme.value, // ✅ RxBool 값을 직접 참조
            onChanged: (val) {
              controller.changeTheme(!controller.isLightTheme.value); // ✅ 즉시 반영되도록 수정
            },
            activeColor: theme.primaryColor,
          ))
              : null,

        );
      });
    } else {
      return ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: theme.textTheme.displayMedium?.copyWith(fontSize: 16.sp),
        ),
        leading: CircleAvatar(
          radius: 30.r,
          backgroundColor: theme.primaryColor,
          child: SvgPicture.asset(icon, fit: BoxFit.none),
        ),
        trailing: isDark
            ? Obx(() => CupertinoSwitch(
          value: !controller.isLightTheme.value, // RxBool 값 사용
          onChanged: onSwitchChanged,
          activeColor: theme.primaryColor,
        ))
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
}







