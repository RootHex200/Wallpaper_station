//import 'dart:html';

import 'dart:io';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class Download_controller {
  download_wallpaper(image_url, context) async {
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context, type: ProgressDialogType.download);
    pr.style(message: "Downloding......");
    var name = await DownloadsPathProvider.downloadsDirectory;
    if (name != null) {
      try {
        await pr.show();
        var save_path = image_url == null
            ? ""
            : name.path + "/${image_url.split("/").last}";

        await Dio().download(
          image_url, save_path,
              onReceiveProgress: (rec, total) {
            var progress = ((rec / total) * 100).toStringAsFixed(0) + "%";
            pr.update(message: "Please wait $progress");
          });
        
        pr.hide();
        Fluttertoast.showToast(msg: "File download in download folder");
      } catch (e) {
        Fluttertoast.showToast(msg: "File not download try again");
      }
    } else {
      Fluttertoast.showToast(msg: "Not found Download Directory");
    }
  }
}
