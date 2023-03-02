import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '/components/auth/login_widget.dart';
import '/stores/auth.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});
  final String title;

  @override
  State<MyLoginPage> createState() => MyLoginPageState();
}

class MyLoginPageState extends State<MyLoginPage> {
  // 1. set
  final Map<String, TextEditingController> textControllers = {
    'ID': TextEditingController(),
    'PW': TextEditingController(),
  };
  SharedPreferences? storage;
  String? token;
  Map<String, dynamic>? decodedToken;
  int? currentTime;

  Future<void> setData() async {
    storage = await SharedPreferences.getInstance();
    token = storage!.getString('token');
    decodedToken = JwtDecoder.decode(token!);
    currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  // 2. init
  @override
  void initState() {
    setData().then((value) {
      if (token != null && decodedToken!['exp'] > currentTime) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        storage!.remove('token');
      }
    }).catchError((onError) {});
    // Future.wait([]);
    super.initState();
  }

  // 3. build
  @override
  Widget build(BuildContext context) {
    return Consumer<Token>(builder: (context, token, child) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person),
                  const Text(" ID :  "),
                  LoginBodyTextfield(
                      title: 'ID', controller: textControllers['ID']!),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.key),
                  const Text("PW : "),
                  LoginBodyTextfield(
                      title: 'PW', controller: textControllers['PW']!),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.height / 9,
                    height: MediaQuery.of(context).size.height / 20,
                    child: LoginBodyButtonSignup(
                      controllers: textControllers,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.height / 27,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.height / 9,
                    height: MediaQuery.of(context).size.height / 20,
                    child: LoginBodyButtonFindpw(
                      controllers: textControllers,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.height / 27,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.height / 9,
                    height: MediaQuery.of(context).size.height / 20,
                    child: LoginBodyButtonLogin(
                      controllers: textControllers,
                      token: token,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
              ),
            ],
          ),
        ),
      );
    });
  }

  // 4. dispose
  @override
  void dispose() {
    for (var controller in textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}
