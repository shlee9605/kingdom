import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Dio api = Dio()
  ..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final storage = await SharedPreferences.getInstance();
        final token = storage.getString('token');
        options.headers['Authorization'] = token;
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        final storage = await SharedPreferences.getInstance();
        await storage.setString(
            'token', response.headers['Authorization']!.first);

        return handler.next(response);
      },
    ),
  );
