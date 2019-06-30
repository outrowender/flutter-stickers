import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interoperabilidade/helpers/file.helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';

class FileView extends StatefulWidget {
  @override
  _FileViewState createState() => _FileViewState();
}

class _FileViewState extends State<FileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Media test'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text('try download'),
              onPressed: () async => {await download()},
            )
          ],
        ),
      ),
    );
  }

  download() async {
    print('start');

    var fh = new FileHelper();

    var result = await fh.downloadFile(
      'https://firebasestorage.googleapis.com/v0/b/flutter-stickers.appspot.com/o/packs%2F1wbd8uVnXEhqzPUBBZFF.zip?alt=media&token=6f1a3cfe-674d-41c2-a6ba-c8499653118f',
      'miojo.zip',
    );

    print(await result.length());

    Directory appDocDir = await getApplicationDocumentsDirectory();

    var file = File('${appDocDir.path}/miojo.zip');

    if (await file.exists()) {
      List<int> fileBytes = file.readAsBytesSync();

      Archive archive = ZipDecoder().decodeBytes(fileBytes);

      for (ArchiveFile file in archive) {
        if (file.isFile) {
          Uint8List fileraw = file.rawContent.toUint8List();
          String fileAs64 = base64.encode(fileraw);
        }
      }
    }

    // appDocDir
    //     .list(recursive: true, followLinks: false)
    //     .listen((FileSystemEntity entity) {
    //   print('${appDocDir.path}/miojo.zip');
    // });
  }
}
