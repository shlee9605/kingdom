import 'package:flutter/material.dart';

void showError(BuildContext context, dynamic error) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text("입력 값을 확인해주세요, $error"),
        actions: <Widget>[
          TextButton(
            child: const Text("확인"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
