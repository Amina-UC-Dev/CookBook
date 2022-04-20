import 'package:cookbook/const/colors.dart';
import 'package:cookbook/provider/provider.dart';
import 'package:cookbook/screen/onboarding/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: CookBookProvider()),
    ],child: MaterialApp(
      title: 'CookBook',
      color: primary,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: primary,
        scaffoldBackgroundColor: white,
      ),
      home: const SplashScreen(),
    ),);
  }
}
