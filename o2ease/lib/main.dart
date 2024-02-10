import 'package:o2ease/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:o2ease/firebase_options.dart';
import 'package:o2ease/screens/auth_part/login.dart';
import 'package:o2ease/screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:o2ease/screens/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }

            if (snapshot.hasData) {
              return const HomePage();
            }
            return const LoginScreen();
          }),
    );
  }
}
