import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_station/controller/hive_provider.dart';
import 'package:wallpaper_station/model/get_wallpaper.dart';
import 'package:wallpaper_station/service/get_wallpaper.dart';

final wallpaperProvider = FutureProvider((ref) async {
  final wallpaperdata = await Get_all_wallpaper().getWallpaperdata();
  final data = WallpaperData.fromJson(wallpaperdata);
  return data;
});


