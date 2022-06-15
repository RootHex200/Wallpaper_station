import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wallpaper_station/controller/get_wallpaper_controller.dart';
import 'package:wallpaper_station/view/pages/all_wallpaper_page.dart';
import 'package:wallpaper_station/view/pages/drawer_page.dart';
import 'package:wallpaper_station/view/widgets/txt_widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../widgets/colors.dart';
import '../widgets/nav_widget.dart';

class Main_page extends HookWidget {
  Main_page({Key? key}) : super(key: key);
  List image_data = [
    "image1.jpg",
    "image2.jpg",
    "image3.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    final tabcontroller = useTabController(initialLength: 3);
    Get_all_wallpaper_controller get_all_wallpaper_controller =
        Get.put(Get_all_wallpaper_controller());
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
                  Nav_bar(
                      icons:
                          Icon(Icons.notifications_none_outlined, size: 30.sp)),
                  Nav_bar(icons: Icon(Icons.settings, size: 30.sp))
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              //search bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15.w),
                    height: 55.h,
                    width: 290.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.grey.withOpacity(0.2)),
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Icon(
                              Icons.search,
                              size: 30.sp,
                              color: Appcolor.custom_grey,
                            )),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text_widgets(
                          txt: "Favourite type hear......",
                          fontsize: 18.sp,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w),
                    height: 55.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.grey.withOpacity(0.2)),
                  )
                ],
              ),

              //tab bar
              SizedBox(
                height: 20.h,
              ),
              Container(
                child: TabBar(
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
                        text: "      New     ",
                      ),
                      Tab(
                        text: "      Popular     ",
                      )
                    ]),
              ),
              Container(
                height: 550.h,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                child: TabBarView(controller: tabcontroller, children: [
                  Obx(
                    () => get_all_wallpaper_controller.category.value.length ==
                            0
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : StaggeredGridView.countBuilder(
                            crossAxisCount: 2,
                            itemCount: get_all_wallpaper_controller
                                .category.value.length,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(All_wallpaper());
                                },
                                child: Container(
                                  height: 290.h,

                                  // margin: EdgeInsets.only(left: 20.w,right: 20.h),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 6,
                                          spreadRadius: 8,
                                          offset: Offset(0, 3),
                                          color: Colors.grey.withOpacity(0.2))
                                    ],
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 210.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                              image: AssetImage(
                                              
                                                  "assets/images/"+image_data[index])),
                                        ),
                                      ),
                                      Text_widgets(
                                        txt: get_all_wallpaper_controller
                                            .category[index].name,
                                        fontsize: 18.sp,
                                      ),
                                      Row(
                                        children: [
                                          Text_widgets(
                                            txt:
                                                '${get_all_wallpaper_controller.category[index].subCategories} wallpaper',
                                            fontWeight: FontWeight.bold,
                                            fontsize: 20.sp,
                                          ),
                                          Expanded(child: Container()),
                                          Container(
                                            height: 40.h,
                                            width: 40.w,
                                            margin: EdgeInsets.only(right: 5.h),
                                            decoration: BoxDecoration(
                                                color: Colors.grey                                                  .withOpacity(0.4),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            child: Icon(Icons.forward),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            staggeredTileBuilder: (index) =>
                                StaggeredTile.fit(1)),
                  ),
                  Container(),
                  Container(),
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
