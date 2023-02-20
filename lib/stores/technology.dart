import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Technologies with ChangeNotifier {
  //state
  List<Technology> technology = [
    Technology("시계탑", "clocktower"),
    Technology("재료 생산 가속1", "mataccel1"),
    Technology("생산품 생산 가속1", "prodaccel1"),
    Technology("재료 생산 가속2", "mataccel2"),
    Technology("생산품 생산 가속2", "prodaccel2"),
    Technology("나무 생산 가속", "wood"),
    Technology("젤리빈 생산 가속", "bean"),
    Technology("각설탕 생산 가속", "sugar"),
    Technology("비스킷 생산 가속", "biscuit"),
    Technology("젤리베리 생산 가속", "berry"),
    Technology("우유 생산 가속", "milk"),
    Technology("양털 생산 가속", "wool"),
    Technology("대장간 생산 가속", "smithy"),
    Technology("잼가게 생산 가속", "jemstore"),
    Technology("공작소 생산 가속", "workshop"),
    Technology("빵집 생산 가속", "bakery"),
    Technology("레스토랑 생산 가속", "restaurant"),
    Technology("도예공방 생산 가속", "pottery"),
    Technology("꽃가게 생산 가속", "flowershop"),
    Technology("우유가공소 생산 가속", "milkplant"),
    Technology("카페 생산 가속", "cafe"),
    Technology("인형공방 생산 가속", "dollshop"),
    Technology("오크통 생산 가속", "oakplant"),
    Technology("파티세리 생산 가속", "patisserie"),
    Technology("쥬얼리 생산 가속", "jewelry"),
  ];

  //getters/setters
  getTechnology() => technology;
  setTechnology(List<Technology> technology) {
    this.technology = technology;
  }

  //actions/mutations
  Future<void> readTechnology(String id) async {
    // 1. Check Response
    final response = await http.get(Uri.parse(
        '${dotenv.env['SERVER_URL']}${dotenv.env['BASE_URL']}user?param=$id'));
    if (response.statusCode != 200) {
      throw HttpException("${response.statusCode}, Invalid GET Reponse");
    }
    final data = json.decode(response.body);

    // 2. Review Bussiness Logic
    try {
      for (int i = 0; i < technology.length; i++) {
        technology[i].level = data['technologies'][technology[i].name];
      }
    } catch (error) {
      throw const HttpException("400, Technology Data Invalid");
    }

    // 3. Apply State Changes
    notifyListeners();
    debugPrint("200, Read Technology Data Success");
  }

  Future<void> updateTechnology(String id) async {
    // 1. Bussiness Logic
    final Map<String, int> params = {};
    for (int i = 0; i < technology.length; i++) {
      if (technology[i].level == null) {
        throw HttpException("400, ${technology[i].name} Data Invalid");
      }
      params[technology[i].name!] = technology[i].level!;
    }

    // 2. Check Response
    final response = await http.put(
        Uri.parse(
            '${dotenv.env['SERVER_URL']}${dotenv.env['BASE_URL']}tree/technologies?param=$id'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(params));
    if (response.statusCode != 200) {
      throw HttpException("${response.statusCode}, Invalid PUT Reponse");
    }

    // 3. Apply State Changes
    notifyListeners();
    debugPrint("200, Update Technology Data Success");
  }
}

class Technology {
  String? display;
  String? name;
  int? level;

  Technology(this.display, this.name);
}
