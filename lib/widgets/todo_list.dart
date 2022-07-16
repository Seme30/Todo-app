import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/constants/dimensions.dart';
import 'package:todoapp/widgets/small_text.dart';


class TodoList extends StatelessWidget {

  final String title;
  final String date;
  final String status;

   const TodoList({required this.title, required this.date, required this.status});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              color: AppColors.secColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                status=='completed'?
                Icon(Icons.check_circle_outline_rounded, color: AppColors.iconColor1)
                : Icon(Icons.circle_outlined,color: AppColors.iconColor1),
                SmallText(text: title, color: AppColors.textColor,),
                SmallText(text: date.substring(0,10), color: AppColors.textColor,)
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.height10,
          )
      ],
    );
  }
}
