//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wallpaper_station/controller/getdataprovider.dart';
import 'package:wallpaper_station/controller/hive_provider.dart';
import 'package:wallpaper_station/view/pages/detials_view.dart';
import 'package:wallpaper_station/view/pages/favourite_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../controller/download_controller.dart';
import '../widgets/nav_widget.dart';
import '../widgets/txt_widgets.dart';

class All_wallpaper extends HookConsumerWidget {
  const All_wallpaper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(wallpaperProvider);
    final tabcontroller = useTabController(initialLength: 3);
    return Scaffold(
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //nav bar part
              Row(
                children: [
                  Nav_bar(
                      icons: Icon(
                    Icons.notes,
                    size: 32.sp,
                  )),
                  Expanded(child: Container()),
                  Container(
                      margin: EdgeInsets.only(top: 35.h),
                      child: Text_widgets(
                        txt: "Walllpaper",
                        fontWeight: FontWeight.bold,
                        fontsize: 22.sp,
                      )),
                  Expanded(child: Container()),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Favourite_page()));
                      },
                      child: Nav_bar(
                          icons: Icon(
                        Icons.favorite_border,
                        size: 40.sp,
                        color: Colors.pink,
                      ))),
                ],
              ),

              //tab bar
              SizedBox(
                height: 20.h,
              ),
              TabBar(
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
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  tabs: const [
                    Tab(
                      text: "      All     ",
                    ),
                    Tab(
                      text: "      Popular     ",
                    ),
                    Tab(
                      text: "      Manga Anime     ",
                    ),
                  ]),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 5.w, right: 5.w),
                child: TabBarView(controller: tabcontroller, children: [
                  /*
                    This is part of All wallpaper 
                  */
                  data.when(
                    error: (error, stacktree) => Text("${error}"),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    data: (data) => StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        itemCount: data.all!.length,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Details_view(
                                            Imageurl: data.all![index],
                                          )));
                            },
                            child: Container(
                              height: 250.h,
                              width: 200.w,

                              // margin: EdgeInsets.only(left: 20.w,right: 20.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  image: DecorationImage(
                                      image: NetworkImage(data.all![index]),
                                      fit: BoxFit.cover)),

                              child: Stack(
                                children: [
                                  Positioned(
                                      right: 0,
                                      child: Consumer(
                                        builder: (context, ref, child) {
                                          return InkWell(
                                            onTap: () {
                                              ref
                                                  .read(hiveProvider.notifier)
                                                  .addData(data.all![index]);
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
                                              child: const Icon(Icons
                                                  .favorite_border_outlined),
                                            ),
                                          );
                                        },
                                      )),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () {
                                          Download_controller()
                                              .download_wallpaper(
                                                  data.all![index], context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              bottom: 20.h, right: 20.w),
                                          height: 35.h,
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(100.r)),
                                          child: const Icon(Icons.download),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                        staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
                  ),

                  /*
                    This is part of Popular wallpaper 
                  */
                  data.when(
                    error: (error, stacktree) => Text("${error}"),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    data: (data) => StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        itemCount: data.popular!.length,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Details_view(
                                            Imageurl: data.popular![index],
                                          )));
                            },
                            child: Container(
                              height: 250.h,
                              width: 200.w,

                              // margin: EdgeInsets.only(left: 20.w,right: 20.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  image: DecorationImage(
                                      image: NetworkImage(data.popular![index]),
                                      fit: BoxFit.cover)),

                              child: Stack(
                                children: [
                                  Positioned(
                                      right: 0,
                                      child: Consumer(
                                        builder: (context, ref, child) {
                                          return InkWell(
                                            onTap: () {
                                              ref
                                                  .read(hiveProvider.notifier)
                                                  .addData(
                                                      data.popular![index]);
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
                                              child: const Icon(Icons
                                                  .favorite_border_outlined),
                                            ),
                                          );
                                        },
                                      )),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () {
                                          Download_controller()
                                              .download_wallpaper(
                                                  data.popular![index],
                                                  context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              bottom: 20.h, right: 20.w),
                                          height: 35.h,
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(100.r)),
                                          child: const Icon(Icons.download),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                        staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
                  ),

                  /*
                    This is part of Managa anime wallpaper 
                  */
                  data.when(
                    error: (error, stacktree) => Text("${error}"),
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                    data: (data) {
                      print("last data");
                      return StaggeredGridView.countBuilder(
                          crossAxisCount: 2,
                          itemCount: data.mangaAnime!.length,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          itemBuilder: (context, index) {
                            return InkWell(
                                                          onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Details_view(Imageurl: data.mangaAnime![index],)));
                            },
                              child: Container(
                                height: 250.h,
                                width: 200.w,
                            
                                // margin: EdgeInsets.only(left: 20.w,right: 20.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(data.mangaAnime![index]),
                                        fit: BoxFit.cover)),
                            
                                child: Stack(
                                  children: [
                                    Positioned(
                                        right: 0,
                                        child: Consumer(
                                          builder: (context, ref, child) {
                                            return InkWell(
                                              onTap: () {
                                                ref
                                                    .read(hiveProvider.notifier)
                                                    .addData(
                                                        data.mangaAnime![index]);
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
                                                child: const Icon(Icons
                                                    .favorite_border_outlined),
                                              ),
                                            );
                                          },
                                        )),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: InkWell(
                                          onTap: () {
                                            Download_controller()
                                                .download_wallpaper(
                                                    data.mangaAnime![index],
                                                    context);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                bottom: 20.h, right: 20.w),
                                            height: 35.h,
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(100.r)),
                                            child: const Icon(Icons.download),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            );
                          },
                          staggeredTileBuilder: (index) =>
                              StaggeredTile.fit(1));
                    },
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
