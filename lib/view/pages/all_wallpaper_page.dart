//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wallpaper_station/controller/hive_controller.dart';
import 'package:wallpaper_station/view/pages/drawer_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../controller/download_controller.dart';
import '../../controller/get_wallpaper_controller.dart';
import '../widgets/nav_widget.dart';
import '../widgets/txt_widgets.dart';
class All_wallpaper extends HookWidget {
  const All_wallpaper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabcontroller = useTabController(initialLength: 4);
    Get_all_wallpaper_controller get_all_wallpaper_controller =
        Get.put(Get_all_wallpaper_controller());
    Download_controller download_controller = Get.put(Download_controller());
    Hive_controller hive_controller = Get.put(Hive_controller());
    return Scaffold(
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //nav bar part
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
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
                        txt: "Natur Walllpaper",
                        fontWeight: FontWeight.bold,
                        fontsize: 22.sp,
                      )),
                  Expanded(child: Container()),
                  Nav_bar(icons: Icon(Icons.search, size: 30.sp)),
                ],
              ),

              //tab bar
              SizedBox(
                height: 20.h,
              ),
              Container(
                child: TabBar(
                    isScrollable: true,
                    controller: tabcontroller,
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.black,
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 19.sp),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    tabs: [
                      Tab(
                        text: "      All     ",
                      ),
                      Tab(
                        text: "      Mount     ",
                      ),
                      Tab(
                        text: "      city     ",
                      ),
                      Tab(
                        text: "      Galaxy     ",
                      ),
                    ]),
              ),

              Container(
                height: 600.h,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 5.w, right: 5.w),
                child: TabBarView(controller: tabcontroller, children: [
                  Obx(
                    () => get_all_wallpaper_controller
                                .get_wallpaper_data.length ==
                            0
                        ? Center(child: CircularProgressIndicator())
                        : StaggeredGridView.countBuilder(
                            crossAxisCount: 2,
                            itemCount: get_all_wallpaper_controller
                                .get_wallpaper_data.length,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 250.h,
                                width: 200.w,

                                // margin: EdgeInsets.only(left: 20.w,right: 20.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            get_all_wallpaper_controller
                                                .get_wallpaper_data[index]),
                                        fit: BoxFit.cover)),

                                child: Stack(
                                  children: [
                                    Positioned(
                                        right: 0,
                                        child: InkWell(
                                          onTap: () {
                                            hive_controller.addData(
                                                get_all_wallpaper_controller
                                                    .get_wallpaper_data[index]);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 20.w, top: 20.h),
                                            height: 35.h,
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.r)),
                                            child: const Icon(
                                                Icons.favorite_border_outlined),
                                          ),
                                        )),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: InkWell(
                                          onTap: () {
                                            download_controller
                                                .download_wallpaper();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                bottom: 20.h, right: 20.w),
                                            height: 35.h,
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.r)),
                                            child: const Icon(Icons.download),
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            },
                            staggeredTileBuilder: (index) =>
                                StaggeredTile.fit(1)),
                  ),
                  Container(),
                  Container(),
                  Container()
                ]),
              )
            ],
          ),
        ),
      ),
      drawer: Drawer_page(),
    );
  }
}
