import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Stickers flutter example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const interoperabilityChannel =
      const MethodChannel('samples.flutter.dev/interoperability');

  String _canSend = 'Teste de ponte whatsapp';

  Future<void> _getBatteryLevel() async {
    String canSend;

    try {
      final bool consegue =
          await interoperabilityChannel.invokeMethod('canSend');

      if (consegue) {
        canSend = "Consegue enviar doido";
      } else {
        canSend = "Nao consegue, instala o zipzop rapidao la doido";
      }
    } on PlatformException catch (e) {
      canSend = "bugo: ${e.message}";
    }

    setState(() {
      _canSend = canSend;
    });
  }

  Future<void> _localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);

    var waStickerJson =
        await rootBundle.loadString('assets/sticker_packs.wasticker');

    Map<String, dynamic> waStickerData = jsonDecode(waStickerJson);

    List<dynamic> stickers = waStickerData["sticker_packs"][0]["stickers"];
    List<dynamic> newstickers = [];

    for (var item in stickers) {
      var file = 'assets/WAStickersPack/webp/' + item["image_file"] + '.webp';

      var img = await rootBundle.load(file);
      var baseImage = base64.encode(img.buffer.asUint8List());

      dynamic data = {};
      data['image_data'] = baseImage;
      data['emojis'] = item['emojis'];

      newstickers.add(data);
    }

    var tray = await rootBundle.load('assets/WAStickersPack/png/' +
        waStickerData['sticker_packs'][0]['tray_image_file'] +
        '.png');

    var toSend = <String, dynamic>{
      'publisher': 'Wender Patrick',
      'tray_image': base64.encode(tray.buffer.asUint8List()),
      'identifier': 'meuovo.esquerdo',
      'name': 'Copinho boiola',
      'stickers': newstickers
    };

    final bool envia =
        await interoperabilityChannel.invokeMethod('send', jsonEncode(toSend));

    //print(envia.toString() + ' resultado do envio');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_canSend',
            ),
            FlatButton(
              onPressed: () {
                _getBatteryLevel();
              },
              child: Text(
                "Testar ponte",
              ),
            ),
            FlatButton(
              onPressed: () async {
                await _localPath();
              },
              child: Text(
                "Testar arquivos",
              ),
            )
          ],
        ),
      ),
    );
  }
}
