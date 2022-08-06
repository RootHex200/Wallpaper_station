import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

import 'package:wallpaper_station/model/boxes.dart';
import 'package:wallpaper_station/model/wallpaper.dart';

final hiveProvider = StateNotifierProvider<HiverNotifier,List<Wallpaper>>((ref) {
  return HiverNotifier();
});

class HiverNotifier extends StateNotifier<List<Wallpaper>>{
  HiverNotifier() : super([]);
  List<Wallpaper> data = [];
  final isChecked = false;

  addData(imageurls) async {
    final wallpaper = Wallpaper()..imageurl = imageurls;

    final box = Boxes.getWallpaper();
    box
        .add(wallpaper)
        .then((value) => Fluttertoast.showToast(msg: 'Data is added'))
        .catchError((e) => Fluttertoast.showToast(msg: 'Try agin'));
  }

  getdata() async {
    try {
      var box = Boxes.getWallpaper();
      data = box.values.toList();
      state = data;
    } catch (e) {
      state = state;
    }
  }

  deletadata(int value) {
    var box = Boxes.getWallpaper();
    box.deleteAt(value).then((value) => getdata()).catchError((e) => getdata());
  }
}
