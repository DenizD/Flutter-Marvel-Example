import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './screens/main_screen.dart';

Future main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MainScreen());
}
