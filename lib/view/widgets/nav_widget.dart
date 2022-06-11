

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Nav_bar extends StatelessWidget {
  final Icon icons;
  Nav_bar({Key? key, required this.icons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.h,
        width: 40.w,
        margin: EdgeInsets.only(left: 10.w, right: 20.w, top: 35.h),
        child:icons);
  }
}
