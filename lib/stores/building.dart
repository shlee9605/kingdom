import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'apiutil.dart';

class Buildings with ChangeNotifier {
  //state
  List<Building> building = [
    Building("나무", "wood"),
    Building("젤리빈", "bean"),
    Building("각설탕", "sugar"),
    Building("비스킷", "biscuit"),
    Building("젤리베리", "berry"),
    Building("우유", "milk"),
    Building("양털", "wool"),
    Building("대장간", "smithy"),
    Building("잼가게", "jemstore"),
    Building("공작소", "workshop"),
    Building("빵집", "bakery"),
    Building("레스토랑", "restaurant"),
    Building("도예공방", "pottery"),
    Building("꽃가게", "flowershop"),
    Building("우유가공소", "milkplant"),
    Building("카페", "cafe"),
    Building("인형공방", "dollshop"),
    Building("오크통", "oakplant"),
    Building("파티세리", "patisserie"),
    Building("쥬얼리", "jewelry"),
  ];

  //getters/setters
  getBuilding() => building;
  setBuilding(List<Building> building) {
    this.building = building;
  }

  //actions/mutations
  Future<void> readBuilding(String id) async {
    // 1. Check Response
    final response = await api.get(
        '${dotenv.env['SERVER_URL']}${dotenv.env['BASE_URL']}user?param=$id');
    if (response.statusCode != 200) {
      throw Exception("${response.statusCode}, Invalid GET Reponse");
    }
    final data = response.data;

    // 2. Review Bussiness Logic
    try {
      for (int i = 0; i < building.length; i++) {
        building[i].number = data['buildings'][building[i].name];
      }
    } catch (error) {
      throw Exception("400, Building Data Invalid");
    }

    // 3. Apply State Changes
    notifyListeners();
    debugPrint("200, Read Building Data Success");
  }

  Future<void> updateBuilding(String id) async {
    // 1. Bussiness Logic
    final Map<String, int> params = {};
    for (int i = 0; i < building.length; i++) {
      if (building[i].number == null) {
        throw Exception("400, ${building[i].name} Data Invalid");
      }
      params[building[i].name!] = building[i].number!;
    }

    // 2. Check Response
    final response = await api.put(
        '${dotenv.env['SERVER_URL']}${dotenv.env['BASE_URL']}tree/buildings?param=$id',
        data: json.encode(params));
    if (response.statusCode != 200) {
      throw Exception("${response.statusCode}, Invalid PUT Reponse");
    }

    // 3. Apply State Changes
    notifyListeners();
    debugPrint("200, Update Building Data Success");
  }
}

class Building {
  String? display;
  String? name;
  int? number;

  Building(this.display, this.name);
}
