import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/home/index.dart';
import 'stores/technology.dart';
import 'stores/building.dart';
import 'stores/product.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Technologies>(
            create: (context) => Technologies(),
          ),
          ChangeNotifierProvider<Buildings>(
            create: (context) => Buildings(),
          ),
          ChangeNotifierProvider<Products>(
            create: (context) => Products(),
          ),
        ],
        child: MaterialApp(
          title: 'Cookie Kingdom',
          theme: ThemeData(
            //app's theme color
            primarySwatch: Colors.amber,
          ),
          home: const MyHomePage(title: 'Home Page'),
        ));
  }
}
