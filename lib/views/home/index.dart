import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/components/home/home_widget.dart';
import '/stores/technology.dart';
import '/stores/building.dart';
import '/stores/product.dart';
import '/stores/auth.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  //first page
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //set
  Future<void> initUserData() async {
    context.read<Technologies>().readTechnology("camel");
    context.read<Buildings>().readBuilding("camel");
    context.read<Products>().readProduct("camel");
    print(context.read<Token>().getCurrentUser().userid);
  }

  //init
  @override
  void initState() {
    initUserData();
    // Future.wait([]);
    super.initState();
  }

  //build
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          // image: AssetImage('assets/images/home.gif'),
          image: AssetImage('assets/images/home.jpeg'),
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                HomeBodySheet(title: "Technology"),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                HomeBodySheet(title: "Products"),
                SizedBox(width: 10),
                HomeBodySheet(title: "Buildings"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const HomeBodyCamera(title: "Camera"),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(
                      height: 150,
                    ),
                    HomeBodyChart(title: "Results"),
                  ],
                ),
              ],
            ),
          ]),
          bottomNavigationBar: Container(
            color: Colors.green,
            height: 50,
            child: const Text('hello'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              debugPrint("${MediaQuery.of(context).size.width}");
              debugPrint("${MediaQuery.of(context).size.height}");
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
