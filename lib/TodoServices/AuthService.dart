import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todoapp/TodoServices/todoDatabase.dart';
import 'package:todoapp/screens/tabs_screen.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> storeTokenandData(UserCredential userCredential) async {
    await TodoDatabase.instance.createUser(userCredential.toString());
  }

  Future<String> getToken() async {
    return await TodoDatabase.instance.readUser();
  }

  Future<void> logOut(BuildContext context) async {
    try {
      await auth.signOut();
      await TodoDatabase.instance.delete();
    } catch (e) {
      final snackBar = SnackBar(
          content: Text(
        e.toString(),
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential) async {
      showSnackBar(context, "Verification Completed");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      showSnackBar(context, exception.toString());
    };
    PhoneCodeSent codeSent = (String verificationID, int? forceResendingToken) {
      setData(verificationID);
      showSnackBar(context, "Verification Code sent on the phonenumber");
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      showSnackBar(context, "Time Out");
    };
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signInWithPhoneNumber(
      BuildContext context, String verificationId, String smsCode) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      storeTokenandData(userCredential);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (builder) => LandingPage(),
          ),
          (route) => false);

      showSnackBar(context, "Logged In");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
