import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'router.dart';

import 'stores/index.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final NavigatorGuardObserver navigationGuard = NavigatorGuardObserver();

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
          ChangeNotifierProvider<Token>(
            create: (context) => Token(),
          ),
        ],
        child: MaterialApp(
          title: 'Cookie Kingdom',
          theme: ThemeData(
            //app's theme color
            primarySwatch: Colors.amber,
          ),
          navigatorObservers: [navigationGuard],
          initialRoute: '/login',
          routes: appRoutes,
        ));
  }
}
