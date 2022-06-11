import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class Download_controller extends GetxController {
  download_wallpaper() async {
    var tempDir = await getApplicationDocumentsDirectory();
    print('This is directory $tempDir');
    var tam = tempDir.path + "/wp1837539.jpg";
    print("this is save directory $tam");
    // var response = await Dio().download('https://wallpapercave.com/wp/wp1837539.jpg', 'wp1837539.jpg');
    var response =
        await Dio().download("https://wallpapercave.com/wp/wp1837539.jpg", tam);
    if (response.statusCode == 200) {
      print("data is download");
      
    }
  }
}
