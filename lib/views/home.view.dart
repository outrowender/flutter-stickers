import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interoperabilidade/models/sticker.model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //funcao que procura e envia os stickers
  Future<void> _sendStickers() async {
    var waStickerData = await _getStickers();

    List<dynamic> stickers = waStickerData["sticker_packs"][0]["stickers"];

    //Cria um pacote de figurinhas
    StickerPack pack = new StickerPack();

    pack.identifier = 'identifier.wender.patrick';
    pack.publisher = 'Wender Patrick';
    pack.name = 'Copinho boiola';

    //pega a figurinha principal
    var tray = await rootBundle.load('assets/WAStickersPack/png/' +
        waStickerData['sticker_packs'][0]['tray_image_file'] +
        '.png');

    pack.trayImage = base64.encode(tray.buffer.asUint8List());

    for (var item in stickers) {
      var file = 'assets/WAStickersPack/webp/' + item["image_file"] + '.webp';

      var img = await rootBundle.load(file);
      var baseImage = base64.encode(img.buffer.asUint8List());
      pack.add(Sticker(baseImage, ['😏', '👌']));
    }

    await pack.sendToWhatsApp();
  }

  //le o pacote de figurinhas
  Future<Map<String, dynamic>> _getStickers() async {
    var data = await rootBundle.loadString('assets/sticker_packs.wasticker');
    return jsonDecode(data);
  }

  //constroi a tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter stickers example'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Clique para enviar as figurinhas para o WhatsApp',
                  ),
                  FlatButton(
                    onPressed: () async {
                      await _sendStickers();
                    },
                    child: Text(
                      "Enviar para o WhatsApp",
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
