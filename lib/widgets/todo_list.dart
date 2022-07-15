import 'package:flutter/material.dart';
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              color: Colors.black26,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                status=='Completed'?Icon(Icons.check_circle_outline_rounded): Icon(Icons.circle_outlined),
                SmallText(text: title),
                SmallText(text: date.substring(0,11))
              ],
            ),
          ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
