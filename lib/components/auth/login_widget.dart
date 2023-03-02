import 'package:basic/components/alertdialog_widget.dart';
import 'package:flutter/material.dart';

import '/stores/auth.dart';

class LoginBodyTextfield extends StatefulWidget {
  const LoginBodyTextfield(
      {super.key, required this.title, required this.controller});
  final String title;
  final TextEditingController controller;

  @override
  State<LoginBodyTextfield> createState() => LoginBodyTextfieldState();
}

class LoginBodyTextfieldState extends State<LoginBodyTextfield> {
  // 1. Set
  bool isFocused = false;
  final focusNode = FocusNode();

  // 2. Init
  @override
  void initState() {
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
    super.initState();
  }

  // 3. Build
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.height / 3,
      height: MediaQuery.of(context).size.height / 15,
      child: TextField(
        controller: widget.controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          filled: true,
          fillColor: isFocused ? Colors.white : Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          hintText: "Enter ${widget.title}",
        ),
      ),
    );
  }

  // 4. Dispose
  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}

class LoginBodyButtonSignup extends StatelessWidget {
  const LoginBodyButtonSignup({
    super.key,
    required this.controllers,
  });
  final Map<String, TextEditingController> controllers;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      onPressed: () {
        debugPrint(controllers['ID']!.text);
      },
      child: const Text('Sign Up', textAlign: TextAlign.center),
    );
  }
}

class LoginBodyButtonFindpw extends StatelessWidget {
  const LoginBodyButtonFindpw({
    super.key,
    required this.controllers,
  });
  final Map<String, TextEditingController> controllers;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
      onPressed: () {
        debugPrint(controllers['PW']!.text);
      },
      child: const Text('Find PW', textAlign: TextAlign.center),
    );
  }
}

class LoginBodyButtonLogin extends StatelessWidget {
  const LoginBodyButtonLogin({
    super.key,
    required this.controllers,
    required this.token,
  });

  final Map<String, TextEditingController> controllers;
  final Token token;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        token.authLogin({
          'user_id': controllers['ID']!.text,
          'pass_word': controllers['PW']!.text,
        }).then((value) {
          Navigator.of(context).pushReplacementNamed('/home');
        }).catchError((onError) {
          showError(context, onError);
        });
      },
      child: const Text("Login", textAlign: TextAlign.center),
    );
  }
}
