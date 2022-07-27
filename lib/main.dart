import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/TodoServices/AuthService.dart';
import 'package:todoapp/TodoServices/todoController.dart';
import 'package:todoapp/TodoServices/dependencies.dart' as dep;
import 'package:todoapp/screens/sign_in_screen.dart';
import 'package:todoapp/screens/tabs_screen.dart';
import './screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
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
    String? tokne = await authService.getToken();
    print("tokne");
    if (tokne != null)
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
    Get.find<TodoController>().getTodoList();

    return GetMaterialApp(
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
