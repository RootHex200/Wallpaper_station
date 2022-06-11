

import 'package:flutter/material.dart';

class Text_widgets extends StatelessWidget {
  final String txt;
  final Color? colors;
  final FontWeight? fontWeight;
  final double? fontsize;

  Text_widgets({Key? key,required this.txt,this.colors,this.fontWeight,this.fontsize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: colors,
        fontStyle: FontStyle.normal,
      ),
    );
  }
}
