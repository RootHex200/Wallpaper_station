

import 'package:hive/hive.dart';

part 'wallpaper.g.dart';

@HiveType(typeId: 0)
class Wallpaper extends HiveObject {
  @HiveField(0)
  late String imageurl;
  
}