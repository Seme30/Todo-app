import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/TodoServices/AuthService.dart';
import 'package:todoapp/TodoServices/todoDatabase.dart';
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
  bool loggedin = false;
  AuthService authService = AuthService();

  late Future<String> getToken;

  Future<String> checkLogin() async {
    String result = await authService.getToken();
    if (result.isNotEmpty) {
      loggedin = true;
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
    getToken = checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        home: loggedin ? LandingPage() : SigninScreen());
  }
}
