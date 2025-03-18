import 'package:flutter/material.dart';

void showEditDialog(BuildContext context, String title, Function(String) onSave) {
  TextEditingController controller = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          //decoration: InputDecoration(hintText: "새로운 값을 입력하세요"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("취소"),
          ),
          TextButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: const Text("저장"),
          ),
        ],
      );
    },
  );
}

