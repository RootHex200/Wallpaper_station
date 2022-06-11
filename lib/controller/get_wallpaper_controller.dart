import 'package:get/get.dart';
import 'package:wallpaper_station/model/jsonplace.dart';
import '../service/get_wallpaper.dart';

class Get_all_wallpaper_controller extends GetxController {
  RxList get_wallpaper_data = RxList([]);
  final category = [].obs;
  void onInit() {
    super.onInit();
    getCategories();
    getWallpaper();
  }

  getWallpaper() async {
    var wallpaper_data = await Get_all_wallpaper().getWallpaperdata();
    get_wallpaper_data.addAll(wallpaper_data);
  }

  getCategories() async {
    var wallpaper_categories = await Get_all_wallpaper().getCategroys();
    category.value = wallpaper_categories;
    print(category.length);
  }
}
