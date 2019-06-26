import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interoperabilidade/models/sticker.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PackView extends StatefulWidget {
  Map pack;
  PackView(this.pack);
  @override
  _PackViewState createState() => _PackViewState(this.pack);
}

class _PackViewState extends State<PackView> {
  Map pack;
  _PackViewState(this.pack);
  //constroi a tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.pack['title']),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () => {},
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('/packs/${pack["id"]}/stickers')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              return GridView.count(
                crossAxisCount: 3,
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return GridTile(
                    child: Card(
                      child: Center(
                        child: Image.network(document['url']),
                      ),
                    ),
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
  //fim do screenbuilder

  //funcao que procura e envia os stickers
  sendStickers() async {
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
}
