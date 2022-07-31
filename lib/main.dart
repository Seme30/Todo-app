import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/TodoServices/DateProvider.dart';
import 'package:todoapp/TodoServices/todoProvider.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/screens/sign_in_screen.dart';
import 'package:todoapp/screens/tabs_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todoapp/widgets/big_text.dart';
import 'firebase_options.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AwesomeNotifications().initialize(
    'resource://drawable/launch_background',
    [
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        channelDescription: 'Channel Description',
        defaultColor: Colors.teal,
        locked: true,
        importance: NotificationImportance.High,
      ),
    ],
  );
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => DateProvider())
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

  late Future<bool> log;

  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String result = prefs.getString('usercredintial') as String;
    if (result.isNotEmpty) {
      setState(() {
        loggedin = true;
      });
    }
    return loggedin;
  }

  @override
  void initState() {
    super.initState();
    log = checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: log,
        builder: ((context, snapshot) {
          while (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return MaterialApp(
                  title: 'Todo App',
                  debugShowCheckedModeBanner: false,
                  home: LandingPage());
            } else {
              return MaterialApp(
                  title: 'Todo App',
                  debugShowCheckedModeBanner: false,
                  home: SigninScreen());
            }
          }
          return MaterialApp(
            home: Scaffold(
              backgroundColor: AppColors.mainColor,
              body: Center(
                  child: BigText(
                text: "Loading...",
                color: AppColors.textColor,
              )),
            ),
          );
        }));
  }
}
