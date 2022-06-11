import 'package:hive/hive.dart';
import 'package:wallpaper_station/model/wallpaper.dart';

class Boxes {
  static Box<Wallpaper> getWallpaper() => 
  Hive.box<Wallpaper>("All_wallpaper");
}
