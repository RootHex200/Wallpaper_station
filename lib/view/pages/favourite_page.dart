import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wallpaper_station/controller/download_controller.dart';
import 'package:wallpaper_station/controller/getdataprovider.dart';
import 'package:wallpaper_station/controller/hive_provider.dart';
import 'package:wallpaper_station/model/wallpaper.dart';

import '../widgets/nav_widget.dart';
import '../widgets/txt_widgets.dart';

class Favourite_page extends HookConsumerWidget {
  const Favourite_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      ref.read(hiveProvider.notifier).getdata();
    }, []);
    List<Wallpaper> data = ref.watch(hiveProvider);
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
            ],
          ),

          Container(
            height: 700.h,
            margin: EdgeInsets.only(left: 10.w, right: 10.w),
            child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: data.length,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                itemBuilder: (context, index) {
                  return data.length==0?const Center(child:CircularProgressIndicator()):Dismissible(
                    key: UniqueKey(),
                    onDismissed: (value) {
                      ref.read(hiveProvider.notifier).deletadata(index);
                    },
                    child: Container(
                      height: 250.h,
                      width: 200.w,
                      // margin: EdgeInsets.only(left: 20.w,right: 20.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          image: DecorationImage(
                              image: NetworkImage(data[index].imageurl),
                              fit: BoxFit.cover)),
                      child: Stack(
                        children: [
                          Positioned(
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  Download_controller().download_wallpaper(
                                      data[index].imageurl, context);
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.only(right: 20.w, top: 20.h),
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
        ],
      ),
    ));
  }
}
