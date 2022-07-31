import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/constants/dimensions.dart';
import 'package:todoapp/widgets/big_text.dart';
import 'package:todoapp/widgets/small_text.dart';

class TodoList extends StatelessWidget {
  final String title;
  final DateTime date;
  final String status;

  const TodoList(
      {required this.title, required this.date, required this.status});

  String getWeekday(DateTime date) {
    switch (date.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      default:
        return 'Sun';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (Dimensions.height30 * 2) + Dimensions.height10,
      width: Dimensions.screenWidth,
      child: Column(
        children: [
          Container(
            height: (Dimensions.height30 * 2) + Dimensions.height10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              color: AppColors.secColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                status == 'Completed'
                    ? Icon(Icons.check_circle_outline_rounded,
                        color: AppColors.iconColor1)
                    : Icon(Icons.circle_outlined, color: AppColors.iconColor1),
                BigText(
                  text: title,
                  color: AppColors.textColor,
                ),
                Container(
                  height: Dimensions.height45,
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.height20,
                      vertical: Dimensions.height10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor),
                  child: Column(
                    children: [
                      BigText(
                        text: getWeekday(date),
                        color: AppColors.textColor,
                        size: Dimensions.font26,
                      ),
                      Row(
                        children: [
                          SmallText(
                              text: '${date.hour.toString()}:',
                              color: AppColors.textColor),
                          SmallText(
                            text: date.minute.toString(),
                            color: AppColors.textColor,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.height10,
          )
        ],
      ),
    );
  }
}
