import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => controller.email = value,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 20.h),
            TextField(
              onChanged: (value) => controller.password = value,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 30.h),
            ElevatedButton(
              onPressed: controller.login,
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
