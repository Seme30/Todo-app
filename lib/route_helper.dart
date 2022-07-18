
import 'package:get/get.dart';
import 'package:todoapp/screens/completed_screen.dart';
import 'package:todoapp/screens/incomplete_screen.dart';
import 'package:todoapp/screens/main_screen.dart';
import 'package:todoapp/screens/sign_in_screen.dart';
import 'package:todoapp/screens/signup_screen.dart';
import 'package:todoapp/screens/tabs_screen.dart';

class RouteHelper{
  
  static const String initial = "/";
  static const String allscreen = '/all-screen';
  static const String completedscreen = "/completed-screen";
  static const String notcompletedscreen = "/notcompleted-screen";
  static const String signinScreen = "/signin-screen";
  static const String signupScreen = "/signup-screen";

  static List<GetPage> routes = [

    GetPage(name: initial, page: ()=> LandingPage()),

    GetPage(name: allscreen, page: ()=> AllScreen()),

    GetPage(name: completedscreen, page: ()=> CompletedScreen()),

    GetPage(name: notcompletedscreen, page: ()=> InCompletedScreen()),

    GetPage(name: signinScreen, page: ()=> SigninScreen()),
    
    GetPage(name: signupScreen, page: ()=> SignupScreen()),

  ]; 

}