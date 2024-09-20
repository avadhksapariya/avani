import 'package:avani/palette.dart';
import 'package:avani/screen_home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AVANI',
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Palette.whiteColor,
        appBarTheme: const AppBarTheme(backgroundColor: Palette.whiteColor),
      ),
      home: const HomePageScreen(),
    );
  }
}
