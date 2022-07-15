import 'package:todoapp/constants/dimensions.dart';
import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final Color color;
  final String text;
  double size;
  TextOverflow overFlow;
   BigText({Key? key, required this.text, this.color = Colors.black ,
  this.size = 0, this.overFlow = TextOverflow.ellipsis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontSize: size==0? Dimensions.font20: size,
        fontWeight: FontWeight.w700,
        fontFamily: 'Raleway'
      ),
      overflow: overFlow,
    );
  }
}