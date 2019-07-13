import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

class FileHelper {
  static var httpClient = new HttpClient();

  Future<File> downloadFile(String url, String filename) async {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  //download file in url and get base64
  static Future<String> downloadPngAndConvertToB64(String url) async {
    var fileHelper = new FileHelper();

    var download = await fileHelper.downloadFile(
      url,
      'image.png',
    );

    return base64Encode(download.readAsBytesSync());
  }
}
