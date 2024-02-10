import 'package:o2ease/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:o2ease/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'O2Ease',
      debugShowCheckedModeBanner: false,//
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.background, scrolledUnderElevation: 0),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: AppColors.color,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
