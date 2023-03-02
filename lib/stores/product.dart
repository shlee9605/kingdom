import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'apiutil.dart';

class Products with ChangeNotifier {
  //state
  List<Product> product = [
    Product("나무", "wood"),
    Product("젤리빈", "bean"),
    Product("각설탕", "sugar"),
    Product("비스킷", "biscuit"),
    Product("젤리베리", "berry"),
    Product("우유", "milk"),
    Product("양털", "wool"),
    Product("도끼", "axe"),
    Product("곡괭이", "pickax"),
    Product("톱", "saw"),
    Product("삽", "shovel"),
    Product("말뚝", "pile"),
    Product("집게", "tongs"),
    Product("망치", "hammer"),
    Product("젤리빈잼", "jellybean_jam"),
    Product("스윗젤리 잼", "sweetjelly_jam"),
    Product("달고나 잼", "dalgona_jam"),
    Product("석류잼", "pomegranate_jam"),
    Product("톡톡베리 잼", "tokberry_jam"),
    Product("솔방울새 인형", "birddoll"),
    Product("램프", "lamp"),
    Product("시계", "clock"),
    Product("드림캐쳐", "dreamcatcher"),
    Product("호밀빵", "ryebread"),
    Product("잼파이", "jampie"),
    Product("포카치아", "pocachia"),
    Product("도넛", "donut"),
    Product("카스텔라", "castella"),
    Product("크로와상", "croissant"),
    Product("젤리스튜", "jellystew"),
    Product("버거", "burger"),
    Product("파스타", "pasta"),
    Product("오므라이스", "omeletrice"),
    Product("피자젤리", "pizzajelly"),
    Product("젤리빈정식", "jellybean_meal"),
    Product("화분", "flower_pot"),
    Product("유리판", "glass_plate"),
    Product("색동구슬", "colored_marble"),
    Product("보울", "bowl"),
    Product("캔디꽃", "candy_flower"),
    Product("행복한꽃화분", "happy_flower"),
    Product("캔디꽃다발", "flower_bundle"),
    Product("꽃바구니", "flower_basket"),
    Product("부케", "bouquet"),
    Product("화환", "wreath"),
    Product("크림", "cream"),
    Product("버터", "butter"),
    Product("수제치즈", "cheese"),
    Product("라떼", "latte"),
    Product("버블티", "bubbletea"),
    Product("에이드", "ade"),
    Product("쿠션", "cushion"),
    Product("곰젤리솜인형", "bearjelly_doll"),
    Product("용과드래곤솜인형", "dragonfruit_dool"),
    Product("갓트비어", "root_beer"),
    Product("레드베리 주스", "redberry_juice"),
    Product("보틀", "wild_bottle"),
    Product("머핀", "spooky_muffin"),
    Product("생딸기케이크", "strawberry_cake"),
    Product("쉬폰케이크", "chiffon_cake"),
    Product("링", "ring"),
    Product("브로치", "brooch"),
    Product("크라운", "crown"),
  ];

  //getters/setters
  getProduct() => product;
  setProduct(List<Product> product) {
    this.product = product;
  }

  //actions/mutations
  Future<void> readProduct(String id) async {
    // 1. Check Response
    final response = await api.get(
        '${dotenv.env['SERVER_URL']}${dotenv.env['BASE_URL']}user?param=$id');
    if (response.statusCode != 200) {
      throw Exception("${response.statusCode}, Invalid GET Reponse");
    }
    final data = response.data;

    // 2. Review Bussiness Logic
    try {
      for (int i = 0; i < product.length; i++) {
        product[i].supplies = data['products'][product[i].name]['supplies'];
        product[i].demands = data['products'][product[i].name]['demands'];
      }
    } catch (error) {
      throw Exception("400, Product Data Invalid");
    }

    // 3. Apply State Changes
    notifyListeners();
    debugPrint("200, Read Product Data Success");
  }

  Future<void> updateProduct(String id) async {
    // 1. Business Logic
    final Map<String, Object> params = {};

    for (int i = 0; i < product.length; i++) {
      if (product[i].supplies == null || product[i].demands == null) {
        throw Exception("400, ${product[i].name} Data Invalid");
      }
      params[product[i].name!] = {
        'supplies': product[i].supplies!,
        'demands': product[i].demands!,
      };
    }

    // 2. Check Response
    final response = await api.put(
        '${dotenv.env['SERVER_URL']}${dotenv.env['BASE_URL']}tree/products?param=$id',
        data: json.encode(params));
    if (response.statusCode != 200) {
      throw Exception("${response.statusCode}, Invalid PUT Reponse");
    }

    // 3. Apply State Changes
    notifyListeners();
    debugPrint("200, Update Product Data Success");
  }
}

class Product {
  String? display;
  String? name;
  String? supplies;
  String? demands;

  Product(this.display, this.name);
}
