import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

import 'views/home/index.dart';
import 'views/auth/index.dart';
import 'views/notfound.dart';

import 'stores/auth.dart';

final appRoutes = {
  '/home': (context) => const MyHomePage(title: 'Home Page'),
  '/login': (context) => const MyLoginPage(title: 'Login Page'),
  '/notfound': (context) => const MyNotFound(),
  '/asdf': (context) => const MyNotFound(),
  '/not_found': (context) => const MyNotFound(),
};

class NavigatorGuardObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _checkAuth(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _checkAuth(newRoute!);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  void _checkAuth(Route<dynamic> route) async {
    //if else Login page,
    if (route.settings.name != '/login' && route.settings.name != null) {
      final SharedPreferences storage = await SharedPreferences.getInstance();
      //try reading storage
      try {
        String? token = storage.getString('token');
        final Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
        final int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

        //if token expires, remove storage then push back to login
        if (decodedToken['exp'] < currentTime) {
          storage.remove('token');
          Navigator.of(route.navigator!.context).pushReplacementNamed('/login');
        }
        //else, save it into store
        else {
          final Token tokenProvider =
              Provider.of<Token>(route.navigator!.context, listen: false);
          tokenProvider.setCurrentUser(
              decodedToken['sub'], decodedToken['exp']);
        }
      }
      //if storage is null, push to login
      catch (error) {
        Navigator.of(route.navigator!.context).pushReplacementNamed('/login');
      }
    }
  }
}
