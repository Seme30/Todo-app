import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/TodoServices/todoModel.dart';
import 'package:todoapp/todo_provider.dart';
import './screens/main_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color.fromRGBO(1, 49, 88, 1),
              secondary: Colors.white,
              tertiary: const Color.fromRGBO(2, 111, 177, 1),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromRGBO(2, 111, 177, 1),
            ),
          ),
          home: MainScreen()),
    );
  }
}
