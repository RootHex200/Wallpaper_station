import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wallpaper_station/model/wallpaper.dart';
import 'package:wallpaper_station/view/pages/all_wallpaper_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WallpaperAdapter());
  await Hive.openBox<Wallpaper>("All_wallpaper");
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home_page(),
     
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
      child:const All_wallpaper(),
    );
  }
}
