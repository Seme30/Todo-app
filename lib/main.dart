import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/TodoServices/AuthService.dart';
import 'package:todoapp/TodoServices/todoProvider.dart';
import 'package:todoapp/screens/sign_in_screen.dart';
import 'package:todoapp/screens/tabs_screen.dart';
import './screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentWidget = SigninScreen();
  AuthService authService = AuthService();

  void checkLogin() async {
    String? token = await authService.getToken();
    print("token");
    if (token != null)
      setState(() {
        currentWidget = LandingPage();
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TodoProvider>(context).readTodos();
    return MaterialApp(
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
        home: currentWidget);
  }
}
