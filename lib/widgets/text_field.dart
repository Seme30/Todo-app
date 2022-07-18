
import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/constants/dimensions.dart';

class TextFieldBuilder extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obsecureText;

  const TextFieldBuilder({Key? key,
    required this.labelText,
    required this.controller,
    required this.obsecureText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.height20*2, vertical: Dimensions.height20),
      height: Dimensions.height20*6,
      child: TextFormField(
        controller: controller,
        obscureText: obsecureText,
        style: TextStyle(
            color: AppColors.textColor,
            fontSize: Dimensions.font16,
          ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.font16,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: BorderSide(width: 1.5, color: AppColors.iconColor1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.height15),
            borderSide: BorderSide(width: 1, color: AppColors.textColor),
          )
        ),
      ),
    );
  }
}
