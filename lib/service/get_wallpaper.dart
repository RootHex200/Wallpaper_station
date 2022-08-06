import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Get_all_wallpaper {
  Future getWallpaperdata() async {
    try {
      var response = await Dio().get("http://192.168.1.10:3000/wallpaper");

      if (response.statusCode == 200) {
        if (response.data != null) {
          return response.data;
        } else {
          return [];
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Not found data");
    }
  }
}
