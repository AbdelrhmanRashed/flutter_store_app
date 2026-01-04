import 'package:app3/core/network/dio_helper.dart';
import 'package:app3/features/splash/splash.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'ReadexPro'),
      debugShowCheckedModeBanner: false,
      home: Splash()
    );
  }
}
