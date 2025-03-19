import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'config/theme/my_theme.dart';
import 'app/data/local/my_shared_pref.dart';
import 'app/routes/app_pages.dart';
import 'config/firebase_options.dart'; // ✅ Firebase 설정 추가

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // ✅ Firebase 초기화
  );

  await MySharedPref.init(); // ✅ SHARED PREFERENCE 초기화 추가

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      rebuildFactor: (old, data) => old != data, // ✅ 불필요한 리빌드 방지
      useInheritedMediaQuery: true,
      builder: (context, child) {
        bool themeIsLight = MySharedPref.getThemeIsLight();

        return GetMaterialApp(
          useInheritedMediaQuery: true,
          title: "STICKY",
          debugShowCheckedModeBanner: false,
          builder: (context, widget) {
            return Theme(
              data: MyTheme.getThemeData(isLight: themeIsLight),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget ?? SizedBox(), // ✅ null 방지
              ),
            );
          },
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    ),
  );
}
