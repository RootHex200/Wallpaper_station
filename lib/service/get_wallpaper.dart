import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallpaper_station/model/categories.dart';

class Get_all_wallpaper {
  Future getWallpaperdata() async {
    try {
      var response = await Dio().get(
          "https://best-manga-anime-wallpapers.p.rapidapi.com/wallpapers/attack-on-titan-hd-wallpapers",
          options: Options(headers: {
            'X-RapidAPI-Host': 'best-manga-anime-wallpapers.p.rapidapi.com',
            'X-RapidAPI-Key':
                '72b8cbfa1cmshb0dee9053314f80p1f7ac2jsnf6994128d8f5'
          }));

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

  Future getCategroys() async {
    try {
      var response = await Dio()
          .get("https://best-manga-anime-wallpapers.p.rapidapi.com/categories",
              options: Options(headers: {
                'X-RapidAPI-Host': 'best-manga-anime-wallpapers.p.rapidapi.com',
                'X-RapidAPI-Key':
                    '72b8cbfa1cmshb0dee9053314f80p1f7ac2jsnf6994128d8f5'
              }));

      if (response.statusCode == 200) {
        if (response.data != null) {
          return response.data
              .map((item) => Categories.fromJson(item))
              .toList();
        } else {
          return [];
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Not found data");
    }
  }
}
