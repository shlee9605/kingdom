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

class HomeSheetBodyTech extends StatelessWidget {
  const HomeSheetBodyTech(
      {super.key, required this.controllers, required this.technology});

  final List<TextEditingController> controllers;
  final Technologies technology;

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
            itemCount: technology.getTechnology().length + 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: index != 0
                              ? Text(
                                  technology.getTechnology()[index - 1].display,
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
                                ? TextField(
                                    controller: controllers[index - 1],
                                    textAlign: TextAlign.center)
                                : const Text("레벨",
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

class HomeSheetBodyBuild extends StatelessWidget {
  const HomeSheetBodyBuild(
      {super.key, required this.controllers, required this.building});

  final List<TextEditingController> controllers;
  final Buildings building;

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
            itemCount: building.getBuilding().length + 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: index != 0
                              ? Text(building.getBuilding()[index - 1].display,
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
                                ? TextField(
                                    controller: controllers[index - 1],
                                    textAlign: TextAlign.center)
                                : const Text("개수",
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

class HomeSheetBodyProd extends StatelessWidget {
  const HomeSheetBodyProd(
      {super.key, required this.controllers, required this.product});

  final Map<String?, List<TextEditingController>> controllers;
  final Products product;

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
            itemCount: product.getProduct().length + 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: index != 0
                              ? Text(product.getProduct()[index - 1].display,
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
                                ? TextField(
                                    controller:
                                        controllers['supplies']![index - 1],
                                    textAlign: TextAlign.center)
                                : const Text("개방",
                                    textAlign: TextAlign.center)),
                        const VerticalDivider(
                          width: 10,
                          color: Color.fromARGB(100, 70, 70, 70),
                          thickness: 1,
                        ),
                        Expanded(
                            child: index != 0
                                ? TextField(
                                    controller:
                                        controllers['demands']![index - 1],
                                    textAlign: TextAlign.center)
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
  final List<TextEditingController> controllers;
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
              try {
                // 1. Set Data
                final technologies = technology.getTechnology();

                // 2. Data Validate
                for (int i = 0; i < technologies.length; i++) {
                  if ((int.parse(controllers[i].text)) > 10) {
                    throw Exception();
                  } else if ((int.parse(controllers[i].text)) > 5 &&
                      i > 0 &&
                      i < 5) {
                    throw Exception();
                  }
                  technologies[i].level = int.parse(controllers[i].text);
                }

                // 3. Execute Logic
                technology.updateTechnology("camel");

                // 4. Response
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
              }
              // et. Error
              catch (error) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text("입력 값을 확인해주세요"),
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
              }
            },
            child: const Text('Submit'),
          ),
          ElevatedButton(
            onPressed: () {
              for (int i = 0; i < technology.getTechnology().length; i++) {
                controllers[i].text = "";
              }
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}

class HomeSheetBottomBuild extends StatelessWidget {
  const HomeSheetBottomBuild(
      {super.key, required this.controllers, required this.building});

  final List<TextEditingController> controllers;
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
              try {
                // 1. Set Data
                final buildings = building.getBuilding();

                // 2. Data Validate
                for (int i = 0; i < buildings.length; i++) {
                  if ((int.parse(controllers[i].text)) > 2 ||
                      (int.parse(controllers[i].text)) < 0) {
                    throw Exception("400, ${buildings[i].name} Data Invalid");
                  }
                  buildings[i].number = int.parse(controllers[i].text);
                }

                // 3. Execute Logic
                building.updateBuilding("camel");

                // 4. Response
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
              }
              // et. Error
              catch (error) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text("입력 값을 확인해주세요"),
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
              }
            },
            child: const Text('Submit'),
          ),
          ElevatedButton(
            onPressed: () {
              for (int i = 0; i < building.getBuilding().length; i++) {
                controllers[i].text = "";
              }
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}

class HomeSheetBottomProd extends StatelessWidget {
  const HomeSheetBottomProd(
      {super.key, required this.controllers, required this.product});

  final Map<String?, List<TextEditingController>> controllers;
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
              try {
                // 1. Set Data
                final products = product.getProduct();
                final supplies = controllers['supplies']!;
                final demands = controllers['demands']!;

                // 2. Data Validate
                for (int i = 0; i < products.length; i++) {
                  if (supplies[i].text != "X" &&
                      supplies[i].text != "O" &&
                      demands[i].text != "X" &&
                      demands[i].text != "O") {
                    throw Exception("400, ${products[i].name} Data Invalid");
                  }
                  products[i].supplies = supplies[i].text;
                  products[i].demands = demands[i].text;
                }

                // 3. Execute Logic
                product.updateProduct("camel");

                // 4. Response
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
              }
              // et. Error
              catch (error) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text("입력 값을 확인해주세요"),
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
              }
            },
            child: const Text('Submit'),
          ),
          ElevatedButton(
            onPressed: () {
              for (int i = 0; i < product.getProduct().length; i++) {
                controllers['supplies']![i].text = "";
                controllers['demands']![i].text = "";
              }
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
