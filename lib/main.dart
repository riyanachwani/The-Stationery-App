import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/login.dart';
import "utils/routes.dart";
import "widget/themes.dart";
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((_) {
    print("Firebase initialized successfully!");
  }).catchError((error) {
    print("Error initializing Firebase: $error");
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner:
          false, //to remove the debug that is shown on app
      initialRoute: MyRoutes.loginRoute,
      routes: {
        "/": (context) => const LoginPage(), //object - can also use new keyword
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
      },
    );
  }
}
