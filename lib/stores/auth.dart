import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'apiutil.dart';

class CurrentUser {
  String? userid;
  int? exp;
}

class Token with ChangeNotifier {
  //state
  CurrentUser currentuser = CurrentUser();

  //getters/setters
  getCurrentUser() => currentuser;
  setCurrentUser(String userid, int exp) {
    currentuser.userid = userid;
    currentuser.exp = exp;
  }

  //mutation/action
  Future<void> authLogin(Map<String, String> params) async {
    // 1. Check Response
    final response = await api.post(
      '${dotenv.env['SERVER_URL']}${dotenv.env['BASE_URL']}token',
      data: json.encode(params),
    );
    if (response.statusCode != 201) {
      throw Exception("${response.statusCode}, ${response.data}");
    }

    // 2. Bussiness Logic
    try {
      String? token = response.headers['authorization']!.first;

      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      setCurrentUser(decodedToken['sub'], decodedToken['exp']);
    } catch (error) {
      throw Exception("400, Setting token Failed");
    }

    // 3. Apply State Changes
    notifyListeners();
    debugPrint("200, Login Success");
  }
}
