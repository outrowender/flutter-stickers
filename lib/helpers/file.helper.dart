import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

class FileHelper {
  static var httpClient = new HttpClient();

  Future<Uint8List> downloadFile(String url) async {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    return await consolidateHttpClientResponseBytes(response);
  }

  //download file in url and get base64
  static Future<String> downloadPngAndConvertToB64(String url) async {
    var fileHelper = new FileHelper();

    var download = await fileHelper.downloadFile(url);

    return base64Encode(download);
  }
}
