import 'package:flutter/material.dart';


class SmallText extends StatelessWidget {

  final Color color;
  final String text;
  double size;
  double height;
  TextOverflow overFlow;
   SmallText({Key? key, required this.text, this.color = Colors.black ,
  this.size = 12, this.overFlow = TextOverflow.ellipsis, this.height = 1.2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
        height: height,
        fontFamily: 'Raleway'
      ),
      overflow: overFlow,
      maxLines: 15,
    );
  }
}