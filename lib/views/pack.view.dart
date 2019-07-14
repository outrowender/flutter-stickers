import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interoperabilidade/helpers/file.helper.dart';
import 'package:interoperabilidade/models/sticker.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PackView extends StatefulWidget {
  StickerPack pack;
  PackView(this.pack);
  @override
  _PackViewState createState() => _PackViewState(this.pack);
}

class _PackViewState extends State<PackView> {
  StickerPack pack;
  List<DocumentSnapshot> data;
  _PackViewState(this.pack);
  //constroi a tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.pack.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () => convertToData(this.data),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('/packs/${pack.identifier}/stickers')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //se houver erros ao carregar o pacote
          if (snapshot.hasError)
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          //loading
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Text('Loading...'),
              );
            //sucesso
            default:
              this.data = snapshot.data.documents;
              return GridView.count(
                crossAxisCount: 4,
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return GridTile(
                    child: Padding(
                      padding: EdgeInsets.all(16),
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

  convertToData(List<DocumentSnapshot> data) async {
    var stickers = data.map((DocumentSnapshot item) async {
      return Sticker(
        imageData: await FileHelper.downloadPngAndConvertToB64(item['url']),
        emojis: (item['emojis'] as Iterable).map((i) => i.toString()).toList(),
      );
    }).toList();

    this.pack.trayImage =
        await FileHelper.downloadPngAndConvertToB64(this.pack.trayImage);

    this.pack.stickers = [];
    for (var item in stickers) {
      this.pack.add(await item);
    }

    //salva o pacote em json
    this.pack.sendToWhatsApp();
  }
}
