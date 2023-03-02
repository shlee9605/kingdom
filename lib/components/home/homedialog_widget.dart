import 'package:basic/components/alertdialog_widget.dart';
import 'package:flutter/material.dart';

import '/stores/technology.dart';
import '/stores/building.dart';
import '/stores/product.dart';

class HomeSheetBar extends StatelessWidget {
  const HomeSheetBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 20,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff34495e),
            Color.fromARGB(255, 96, 136, 176),
            Color(0xff34495e),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.3),
            offset: const Offset(0, 2),
            blurRadius: 10.0,
            spreadRadius: 5.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 10,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeSheetBodyTech extends StatefulWidget {
  const HomeSheetBodyTech(
      {super.key, required this.controllers, required this.technology});
  final List<String> controllers;
  final Technologies technology;

  @override
  HomeSheetBodyTechState createState() => HomeSheetBodyTechState();
}

class HomeSheetBodyTechState extends State<HomeSheetBodyTech> {
  // 1. Set Data
  final valueList_5 = {'0', '1', '2', '3', '4', '5'};
  final valueList_10 = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'};
  List<String> controllers = [];
  List<Technology> technologies = [];

  // 2. Init Data
  @override
  void initState() {
    super.initState();
    technologies = widget.technology.getTechnology();
    controllers = widget.controllers;
  }

  // 3. Build Widget
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: const Color.fromARGB(100, 70, 70, 70), width: 1.0),
          ),
          child: ListView.builder(
            itemCount: technologies.length + 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: index != 0
                              ? Text(technologies[index - 1].display!,
                                  textAlign: TextAlign.center)
                              : const Text("연구", textAlign: TextAlign.center),
                        ),
                        const VerticalDivider(
                          width: 10,
                          color: Color.fromARGB(100, 70, 70, 70),
                          thickness: 1,
                        ),
                        Expanded(
                          child: index != 0
                              ? Center(
                                  child: DropdownButton(
                                      value: controllers[index - 1],
                                      onChanged: (value) {
                                        setState(() {
                                          controllers[index - 1] =
                                              value.toString();
                                        });
                                      },
                                      items: index > 1 && index < 6
                                          ? valueList_5.map((item) {
                                              return DropdownMenuItem(
                                                value: item,
                                                child: Text(item),
                                              );
                                            }).toList()
                                          : valueList_10.map((item) {
                                              return DropdownMenuItem(
                                                value: item,
                                                child: Text(item),
                                              );
                                            }).toList()),
                                )
                              : const Text("레벨", textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 10,
                    color: Color.fromARGB(100, 70, 70, 70),
                    thickness: 1,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class HomeSheetBodyBuild extends StatefulWidget {
  const HomeSheetBodyBuild(
      {super.key, required this.controllers, required this.building});

  final List<String> controllers;
  final Buildings building;

  @override
  HomeSheetBodyBuildState createState() => HomeSheetBodyBuildState();
}

class HomeSheetBodyBuildState extends State<HomeSheetBodyBuild> {
  // 1. Set Data
  final valueList = {'0', '1', '2'};
  List<String> controllers = [];
  List<Building> buildings = [];

  // 2. Init Data
  @override
  void initState() {
    super.initState();
    buildings = widget.building.getBuilding();
    controllers = widget.controllers;
  }

  // 3. Build Widget
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: const Color.fromARGB(100, 70, 70, 70), width: 1.0),
          ),
          child: ListView.builder(
            itemCount: buildings.length + 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: index != 0
                              ? Text(buildings[index - 1].display!,
                                  textAlign: TextAlign.center)
                              : const Text("건물", textAlign: TextAlign.center),
                        ),
                        const VerticalDivider(
                          width: 10,
                          color: Color.fromARGB(100, 70, 70, 70),
                          thickness: 1,
                        ),
                        Expanded(
                          child: index != 0
                              ? Center(
                                  child: DropdownButton(
                                      value: controllers[index - 1],
                                      onChanged: (value) {
                                        setState(() {
                                          controllers[index - 1] =
                                              value.toString();
                                        });
                                      },
                                      items: valueList.map((item) {
                                        return DropdownMenuItem(
                                          value: item,
                                          child: Text(item),
                                        );
                                      }).toList()),
                                )
                              : const Text("개수", textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 10,
                    color: Color.fromARGB(100, 70, 70, 70),
                    thickness: 1,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class HomeSheetBodyProd extends StatefulWidget {
  const HomeSheetBodyProd(
      {super.key, required this.controllers, required this.product});

  final Map<String, List<String>> controllers;
  final Products product;

  @override
  HomeSheetBodyProdState createState() => HomeSheetBodyProdState();
}

class HomeSheetBodyProdState extends State<HomeSheetBodyProd> {
  // 1. Set Data
  final valueList = {'O', 'X'};
  Map<String, List<String>> controllers = {};
  List<Product> products = [];

  // 2. Init Data
  @override
  void initState() {
    super.initState();
    products = widget.product.getProduct();
    controllers = widget.controllers;
  }

  // 3. Build Widget
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: const Color.fromARGB(100, 70, 70, 70), width: 1.0),
          ),
          child: ListView.builder(
            itemCount: products.length + 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: index != 0
                              ? Text(products[index - 1].display!,
                                  textAlign: TextAlign.center)
                              : const Text("제품", textAlign: TextAlign.center),
                        ),
                        const VerticalDivider(
                          width: 10,
                          color: Color.fromARGB(100, 70, 70, 70),
                          thickness: 1,
                        ),
                        Expanded(
                            child: index != 0
                                ? Center(
                                    child: DropdownButton(
                                        value:
                                            controllers['supplies']![index - 1],
                                        onChanged: (value) {
                                          setState(() {
                                            controllers['supplies']![
                                                index - 1] = value.toString();
                                          });
                                        },
                                        items: valueList.map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            child: Text(item),
                                          );
                                        }).toList()),
                                  )
                                : const Text("개방",
                                    textAlign: TextAlign.center)),
                        const VerticalDivider(
                          width: 10,
                          color: Color.fromARGB(100, 70, 70, 70),
                          thickness: 1,
                        ),
                        Expanded(
                            child: index != 0
                                ? Center(
                                    child: DropdownButton(
                                        value:
                                            controllers['demands']![index - 1],
                                        onChanged: (value) {
                                          setState(() {
                                            controllers['demands']![index - 1] =
                                                value.toString();
                                          });
                                        },
                                        items: valueList.map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            child: Text(item),
                                          );
                                        }).toList()),
                                  )
                                : const Text("납품 허용",
                                    textAlign: TextAlign.center)),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 10,
                    color: Color.fromARGB(100, 70, 70, 70),
                    thickness: 1,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class HomeSheetBottomTech extends StatelessWidget {
  const HomeSheetBottomTech(
      {super.key, required this.controllers, required this.technology});
  final List<String> controllers;
  final Technologies technology;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              // 1. Set Data
              final technologies = technology.getTechnology();
              for (int i = 0; i < technologies.length; i++) {
                technologies[i].level = int.parse(controllers[i]);
              }

              // 2. Execute Logic
              technology.updateTechnology("camel").then((value) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text("수정 완료"),
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
              }).catchError((onError) {
                showError(context, onError);
              });
            },
            child: const Text('Submit'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class HomeSheetBottomBuild extends StatelessWidget {
  const HomeSheetBottomBuild(
      {super.key, required this.controllers, required this.building});

  final List<String> controllers;
  final Buildings building;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              // 1. Set Data
              final buildings = building.getBuilding();
              for (int i = 0; i < buildings.length; i++) {
                buildings[i].number = int.parse(controllers[i]);
              }

              // 2. Execute Logic
              building.updateBuilding("camel").then((value) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text("수정 완료"),
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
              }).catchError((onError) {
                showError(context, onError);
              });
            },
            child: const Text('Submit'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class HomeSheetBottomProd extends StatelessWidget {
  const HomeSheetBottomProd(
      {super.key, required this.controllers, required this.product});

  final Map<String, List<String>> controllers;
  final Products product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              // 1. Set Data
              final products = product.getProduct();
              final supplies = controllers['supplies']!;
              final demands = controllers['demands']!;
              for (int i = 0; i < products.length; i++) {
                products[i].supplies = supplies[i];
                products[i].demands = demands[i];
              }

              // 2. Execute Logic
              product.updateProduct("camel").then((value) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text("수정 완료"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("확인"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              }).catchError((onError) {
                showError(context, onError);
              });
            },
            child: const Text('Submit'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
