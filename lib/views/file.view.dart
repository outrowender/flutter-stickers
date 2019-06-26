import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interoperabilidade/helpers/file.helper.dart';
import 'package:path_provider/path_provider.dart';

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
      'https://firebasestorage.googleapis.com/v0/b/flutter-stickers.appspot.com/o/packs%2F1wbd8uVnXEhqzPUBBZFF.zip?alt=media&token=4431a405-8e5e-4048-a1a9-ec2a1f31c55c',
      'miojo.zip',
    );

    print(await result.length());

    Directory appDocDir = await getApplicationDocumentsDirectory();

    appDocDir
        .list(recursive: true, followLinks: false)
        .listen((FileSystemEntity entity) {
      print(entity.path);
    });
  }
}
