import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

// flutter run -d chrome --web-port=8080
// flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080