// import 'package:flutter/cupertino.dart';
import 'package:basic/stores/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/components/home/homedialog_widget.dart';
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

  static void homeBodyCamera(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: MediaQuery.of(context).size.width / 2,
            width: MediaQuery.of(context).size.height / 2,
            child: Scaffold(
                appBar: AppBar(
                  title: const Text('Modal'),
                ),
                body: const Text('hello world'),
                bottomNavigationBar: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                      child: const Text("to Login"),
                    ),
                  ],
                )),
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
  List<String> _controllers = [];

  @override
  void initState() {
    List<Technology> technologies =
        context.read<Technologies>().getTechnology();
    _controllers = List.generate(
        technologies.length, (index) => technologies[index].level.toString());
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
  List<String> _controllers = [];

  @override
  void initState() {
    super.initState();
    List<Building> buildings = context.read<Buildings>().getBuilding();
    _controllers = List.generate(
        buildings.length, (index) => buildings[index].number.toString());
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
  final Map<String, List<String>> _controllers = {
    'supplies': [],
    'demands': [],
  };

  @override
  void initState() {
    super.initState();
    List<Product> products = context.read<Products>().getProduct();
    for (int i = 0; i < products.length; i++) {
      _controllers['supplies'] = List.generate(
          products.length, (index) => products[index].supplies.toString());
      _controllers['demands'] = List.generate(
          products.length, (index) => products[index].demands.toString());
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
