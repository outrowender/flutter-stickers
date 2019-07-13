import 'package:flutter/material.dart';
import 'package:interoperabilidade/models/sticker.model.dart';
import 'package:interoperabilidade/views/file.view.dart';
import 'package:interoperabilidade/views/pack.view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter a search term',
            icon: Icon(Icons.search),
          ),
          autocorrect: false,
          textInputAction: TextInputAction.search,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.perm_media),
            onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FileView()),
                  )
                },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('packs').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              return ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return ListTile(
                    title: Text(document['name']),
                    subtitle: Text(document['author']),
                    trailing: Image.network(document['tray_image']),
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              StickerPack pack = new StickerPack();
                              pack.identifier = document.documentID;
                              pack.name = document['name'];
                              pack.publisher = document['author'];
                              pack.trayImage = document['tray_image'];
                              return PackView(pack);
                            }),
                          )
                        },
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}
