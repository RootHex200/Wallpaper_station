import 'package:hive/hive.dart';

import 'package:get/get.dart';
import 'package:wallpaper_station/model/boxes.dart';
import 'package:wallpaper_station/model/wallpaper.dart';

class Hive_controller extends GetxController {
  final data = <Wallpaper>[].obs;
  final isChecked = false.obs;
  @override
  void onInit() {
    super.onInit();
    getdata();
  }

  addData(imageurls) async {
    final wallpaper = Wallpaper()..imageurl = imageurls;

    final box = Boxes.getWallpaper();
    box
        .add(wallpaper)
        .then((value) => print("data is added"))
        .catchError((e) => print(e));
  }

  getdata() async {
    var box = Boxes.getWallpaper();
    data.value = box.values.toList().cast<Wallpaper>();
    print(data.value.length);
  }

  deletadata(int value) {
    var box = Boxes.getWallpaper();
    box.deleteAt(value).then((value) => getdata()).catchError((e) => getdata());
  }

}
