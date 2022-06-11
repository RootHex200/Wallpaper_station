import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:wallpaper_station/controller/hive_controller.dart';

import '../widgets/nav_widget.dart';
import '../widgets/txt_widgets.dart';

class Favourite_page extends HookWidget {
  const Favourite_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Hive_controller hive_controller = Get.put(Hive_controller());
    useEffect(() {
      hive_controller.onInit();
    });
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          //nav_bar
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Nav_bar(
                    icons: Icon(
                  Icons.notes,
                  size: 32.sp,
                )),
              ),
              Expanded(child: Container()),
              Container(
                  margin: EdgeInsets.only(top: 35.h),
                  child: Text_widgets(
                    txt: "Favourite",
                    fontWeight: FontWeight.bold,
                    fontsize: 22.sp,
                  )),
              Expanded(child: Container()),
              InkWell(
                  onTap: () {
                    hive_controller.getdata();
                  },
                  child: Nav_bar(icons: Icon(Icons.search, size: 30.sp))),
            ],
          ),

          Container(
            height: 700.h,
            margin: EdgeInsets.only(left: 10.w, right: 10.w),
            child: Obx(
              () => hive_controller.data.value.length == 0
                  ? Center(child: CircularProgressIndicator())
                  : 
                  StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemCount: hive_controller.data.value.length,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (value) {
                            hive_controller.deletadata(index);
                          },
                          child: Container(
                            height: 250.h,
                            width: 200.w,
                            // margin: EdgeInsets.only(left: 20.w,right: 20.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        hive_controller.data[index].imageurl),
                                    fit: BoxFit.cover)),
                            child: Stack(
                              children: [
                                Positioned(
                                    right: 0,
                                    child: InkWell(
                                      onTap: () {
                                        hive_controller.addData(
                                            "https://wallpapercave.com/wp/wp1837539.jpg");
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            right: 20.w, top: 20.h),
                                        height: 35.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(100.r)),
                                        child: const Icon(Icons.download),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
            ),
          ),
        ],
      ),
    ));
  }
}
