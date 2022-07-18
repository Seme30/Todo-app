import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/constants/dimensions.dart';
import 'package:todoapp/route_helper.dart';
import 'package:todoapp/widgets/big_text.dart';
// import 'package:todo_app/services/AuthService.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {

  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  // AuthService authServcie = AuthService();
  String verificationIdFinal = "";
  String smsCode = "";

  void startTimer(){
    const onsec = Duration(seconds: 1);

    Timer _timer = Timer.periodic(onsec, (timer) {
      if(start== 0){
        setState(() {
          timer.cancel();
          wait = false;
        });
      }else{
        setState(() {
          start--;
        });
      }
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.toNamed(RouteHelper.signinScreen);
          }, 
          icon: Container(
              padding: EdgeInsets.all(Dimensions.height10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.iconColor1
              ),
              child: Icon(Icons.arrow_back_ios)),
              iconSize: Dimensions.iconSize16
          ),
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: BigText(text: 'Sign Up', color: AppColors.textColor,),
      centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Dimensions.height30*4),
              textField(),
              SizedBox(height: Dimensions.height20,),
              SizedBox(
                width: MediaQuery.of(context).size.width - Dimensions.width20,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        margin:  EdgeInsets.symmetric(horizontal: Dimensions.height10),
                        color: Colors.grey,),),
                      Text(
                      'Enter 6 digit OTP',
                      style: TextStyle(fontSize: Dimensions.font16, color: Colors.white),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: Dimensions.height10),
                        color: Colors.grey,),),    
                  ],),
                  ),
             SizedBox(height: Dimensions.height30,),
              otpField(),
               SizedBox(height: Dimensions.height20*2,),
              RichText(
                text: TextSpan(
                  children: [
                     TextSpan(
                      text: "Send OTP again in ",
                      style: TextStyle(fontSize: Dimensions.font16, color: AppColors.textColor)
                    ),
                    TextSpan(
                      text: "00:$start",
                      style:  TextStyle(fontSize: Dimensions.font16, color: AppColors.iconColor1)
                    ),
                     TextSpan(
                      text: " sec",
                      style: TextStyle(fontSize: Dimensions.font16, color: AppColors.textColor)
                    ),
                  ],
              ),),
              SizedBox(height: Dimensions.height30*4,),
              InkWell(
                onTap: (){
                  // authServcie.signInWithPhoneNumber(context, verificationIdFinal, smsCode);
                },
                child: Container(
                  height: Dimensions.height30*2,
                  width: MediaQuery.of(context).size.width - (Dimensions.height30*2),
                  decoration: BoxDecoration(
                    color: AppColors.secColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                  ),
                  child: Center(
                    child: BigText(text: "Lets Go",color: AppColors.textColor,)
                  )
                ),
              ),
            ]
            ),
        ),
      ),
    );
  }

  Widget otpField(){
    return OTPTextField(
  length: 6,
  width: MediaQuery.of(context).size.width - 34,
  fieldWidth: (Dimensions.width20*2)+Dimensions.width10,
  otpFieldStyle: OtpFieldStyle(
    backgroundColor: AppColors.secColor,
    borderColor: AppColors.iconColor1,
  ),
  style: TextStyle(
    fontSize: Dimensions.font16, color: AppColors.iconColor1,
  ),
  textFieldAlignment: MainAxisAlignment.spaceAround,
  fieldStyle: FieldStyle.underline,
  onCompleted: (pin) {
    print("Completed: " + pin);
    setState(() {
      smsCode = pin;
    });
  },
);
  }

  Widget textField(){
    return Container(
      width: MediaQuery.of(context).size.width -40,
      height: Dimensions.height20*4,
      decoration: BoxDecoration(
        color: AppColors.secColor,
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        ),
        child: Center(
          child: TextFormField( 
            style: TextStyle(color: AppColors.iconColor1),
            controller: phoneController,
            decoration:  InputDecoration(
              border: InputBorder.none,
              hintText: "Enter Your Phone Number",
              hintStyle: TextStyle(color: Colors.white54, fontSize: Dimensions.font16),
              contentPadding: EdgeInsets.symmetric(vertical: Dimensions.height15, horizontal: Dimensions.width10),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.height15, horizontal: Dimensions.width15),
                child: Text('+251',style: TextStyle(color: AppColors.textColor, fontSize: Dimensions.font16),),
              ),
              suffixIcon: InkWell(
                onTap: wait? null: () async {
                  startTimer();
                  setState(() {
                    start = 30;
                    wait = true;
                    buttonName = "Resend"; 
                  });
                  // await authServcie.verifyPhoneNumber("+251 ${phoneController.text}", context, setData);
                  
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.width15, horizontal: Dimensions.width15),
                  child: Text(
                    buttonName,
                    style: TextStyle(
                      color: wait? AppColors.textColor: AppColors.textColor, fontSize: Dimensions.font16,fontWeight: FontWeight.bold,),),
                ),
              )
              ),
          ),
        ),
    );
  }

  void setData(String verificationId){
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }
}