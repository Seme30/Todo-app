import 'package:flutter/material.dart';
import './screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromRGBO(1, 49, 88, 1),
            secondary: Colors.white,
          ),
          appBarTheme: const AppBarTheme(
            color: Color.fromRGBO(2, 111, 177, 1),
          ),
        ),
        home: MainScreen());
  }
}
