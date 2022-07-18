import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/constants/dimensions.dart';
import 'package:todoapp/route_helper.dart';
import 'package:todoapp/widgets/big_text.dart';
import 'package:todoapp/widgets/text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
    
    return Scaffold(
      appBar: AppBar(
        title:  BigText(text: 'Sign Up', color: AppColors.textColor),
        backgroundColor: AppColors.mainColor,
        elevation: 0,
      ),
      backgroundColor: AppColors.mainColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.width30*2, vertical: Dimensions.width20),
          height: Dimensions.screenHeight,
          width: Dimensions.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.height30,),
              InkWell(
                onTap: (){},
                child: Container(
                  height: Dimensions.height20*4,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.width20),
                  decoration: BoxDecoration(
                    color: AppColors.secColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius15)  
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('images/phone.svg'),
                      BigText(text: 'Continue with Mobile', color: AppColors.textColor,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height30,),
              Container(
                height: Dimensions.height450-Dimensions.width30*2,
                child: Card(
                  elevation: 5,
                  color: AppColors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        side: BorderSide(width: 2, color: AppColors.iconColor1),),  
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFieldBuilder(labelText: "Email", controller: _emailController,obsecureText: false),
                        TextFieldBuilder(labelText: "Password", controller: _passwordController,obsecureText: true),
                        SizedBox(height: Dimensions.height54,),
                         InkWell(
                          onTap: (){},
                                child: Container(
                                margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.width20),
                                padding: EdgeInsets.symmetric(vertical: Dimensions.width20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                                  color: AppColors.secColor
                                ),
                                    child: Center(child: BigText(text: "Sign Up", color: AppColors.textColor)),
                                  ),
                              ),
                      ],
                    ),
                  ),
              ),
              // SizedBox(height: Dimensions.height15,),
              // SizedBox(height: Dimensions.height15,),
              Container(
                margin: EdgeInsets.all(Dimensions.height30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigText(text: 'Already have an Account?', color: AppColors.textColor,),
                    SizedBox(width: Dimensions.width20,),
                    InkWell(
                      onTap: (){
                      },
                      child: BigText(text: 'Log In', color: AppColors.textColor,),
                    ),
                  ],),
              ),
              SizedBox(height: Dimensions.height10),
              InkWell(
                onTap: (){
                  Get.toNamed(RouteHelper.initial);
                },
                child: BigText(text: 'Forgot Password?', color: AppColors.textColor,))
            ],
          ),
        ),
      ),
    );
  }
}