import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallpaper_station/model/wallpaper.dart';
import 'package:wallpaper_station/view/drawerpage/favourite_page.dart';
import 'package:wallpaper_station/view/pages/all_wallpaper_page.dart';
import 'package:wallpaper_station/view/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WallpaperAdapter());
  await Hive.openBox<Wallpaper>("All_wallpaper");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home_page(),
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.green),
    );
  }
}

class Home_page extends StatelessWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appheight = MediaQuery.of(context).size.height;
    var appwidth = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
      designSize: Size(appwidth, appheight),
      builder: (context, child) {
        return Material(
          child: child,
        );
      },
      child:Main_page(),
    );
  }
}
