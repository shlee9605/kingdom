// import 'package:flutter/cupertino.dart';
import 'package:basic/stores/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/components/homedialog_widget.dart';
import '/stores/technology.dart';
import '/stores/building.dart';

class Modal {
  static void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Modal'),
              ),
              body: const Text('hello world'),
            ),
          ),
        );
      },
    );
  }

  static Map<String, Widget> titleToWidget = {
    "Technology": const HomeSheetTech(title: "Technology"),
    "Buildings": const HomeSheetBuild(title: "Buildings"),
    "Products": const HomeSheetProd(title: "Products"),
  };

  static void homeBodySheet(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 2,
            color: Colors.white,
            child: titleToWidget[title],
          ),
        );
      },
    );
  }
}

class HomeSheetTech extends StatefulWidget {
  const HomeSheetTech({super.key, required this.title});
  final String title;

  @override
  HomeSheetTechState createState() => HomeSheetTechState();
}

class HomeSheetTechState extends State<HomeSheetTech> {
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    List<Technology> technologies =
        context.read<Technologies>().getTechnology();
    for (int i = 0; i < technologies.length; i++) {
      _controllers
          .add(TextEditingController(text: technologies[i].level.toString()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Technologies>(builder: (context, technology, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          HomeSheetBar(title: widget.title),
          HomeSheetBodyTech(controllers: _controllers, technology: technology),
          HomeSheetBottomTech(
              controllers: _controllers, technology: technology),
        ],
      );
    });
  }
}

class HomeSheetBuild extends StatefulWidget {
  const HomeSheetBuild({super.key, required this.title});
  final String title;

  @override
  HomeSheetBuildState createState() => HomeSheetBuildState();
}

class HomeSheetBuildState extends State<HomeSheetBuild> {
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    List<Building> buildings = context.read<Buildings>().getBuilding();
    for (int i = 0; i < buildings.length; i++) {
      _controllers
          .add(TextEditingController(text: buildings[i].number.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Buildings>(builder: (context, building, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          HomeSheetBar(title: widget.title),
          HomeSheetBodyBuild(controllers: _controllers, building: building),
          HomeSheetBottomBuild(controllers: _controllers, building: building),
        ],
      );
    });
  }
}

class HomeSheetProd extends StatefulWidget {
  const HomeSheetProd({super.key, required this.title});
  final String title;

  @override
  HomeSheetProdState createState() => HomeSheetProdState();
}

class HomeSheetProdState extends State<HomeSheetProd> {
  final Map<String?, List<TextEditingController>> _controllers = {
    'supplies': [],
    'demands': [],
  };

  @override
  void initState() {
    super.initState();
    List<Product> products = context.read<Products>().getProduct();
    for (int i = 0; i < products.length; i++) {
      _controllers['supplies']!
          .add(TextEditingController(text: products[i].supplies.toString()));
      _controllers['demands']!
          .add(TextEditingController(text: products[i].demands.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Products>(builder: (context, product, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          HomeSheetBar(title: widget.title),
          HomeSheetBodyProd(controllers: _controllers, product: product),
          HomeSheetBottomProd(controllers: _controllers, product: product),
        ],
      );
    });
  }
}
