import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wallpaper_station/view/drawerpage/favourite_page.dart';
import 'package:wallpaper_station/view/widgets/colors.dart';
import 'package:wallpaper_station/view/widgets/txt_widgets.dart';

class Drawer_page extends StatelessWidget {
  const Drawer_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Appcolor.drawer_color,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(top: 70.h, left: 20.w),
                child: Text_widgets(
                  txt: "Logo",
                  fontWeight: FontWeight.bold,
                  colors: Colors.white,
                  fontsize: 22.sp,
                )),
            SizedBox(
              height: 40.h,
            ),
            ListTile(
              title: Text_widgets(
                txt: "Latest",
                fontsize: 25.sp,
                colors: Colors.white,
              ),
              leading: Icon(
                Icons.new_label,
                color: Colors.white,
              ),
            ),
            ListTile(
              title: Text_widgets(
                txt: "Categories",
                fontsize: 25.sp,
                colors: Colors.white,
              ),
              leading: Icon(
                Icons.category,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Get.to(Favourite_page());
              },
              title: Text_widgets(
                txt: "Favorites",
                fontsize: 25.sp,
                colors: Colors.white,
              ),
              leading: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ),
            ListTile(
              title: Text_widgets(
                txt: "Gifts",
                fontsize: 25.sp,
                colors: Colors.white,
              ),
              leading: Icon(
                Icons.star,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
