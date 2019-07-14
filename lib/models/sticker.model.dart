import 'dart:convert';

import 'package:flutter/services.dart';

StickerPack stickerPackFromJson(String str) =>
    StickerPack.fromJson(json.decode(str));

String stickerPackToJson(StickerPack data) => json.encode(data.toJson());

class StickerPack {
  String iosAppStoreLink;
  String androidPlayStoreLink;
  String identifier;
  String name;
  String publisher;
  String trayImage;
  List<Sticker> stickers;

  //constructor
  StickerPack({
    this.iosAppStoreLink,
    this.androidPlayStoreLink,
    this.identifier,
    this.name,
    this.publisher,
    this.trayImage,
    this.stickers,
  });

  factory StickerPack.fromJson(Map<String, dynamic> json) => new StickerPack(
        iosAppStoreLink: json["ios_app_store_link"],
        androidPlayStoreLink: json["android_play_store_link"],
        identifier: json["identifier"],
        name: json["name"],
        publisher: json["publisher"],
        trayImage: json["tray_image"],
        stickers: new List<Sticker>.from(
            json["stickers"].map((x) => Sticker.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ios_app_store_link": iosAppStoreLink,
        "android_play_store_link": androidPlayStoreLink,
        "identifier": identifier,
        "name": name,
        "publisher": publisher,
        "tray_image": trayImage,
        "stickers": new List<dynamic>.from(stickers.map((x) => x.toJson())),
      };

  static const interoperabilityChannel =
      const MethodChannel('interoperabilityChannel');

  //add sticker to list
  void add(Sticker sticker) {
    stickers.add(sticker);
  }

  //add multiple stickers
  void addRange(List<Sticker> stickers) {
    stickers.addAll(stickers);
  }

  //remove sticker
  void remove(int index) {
    stickers.removeAt(index);
  }

  //Whatsapp can be call on app?
  Future<bool> canSendToWhatsapp() async {
    return await interoperabilityChannel.invokeMethod(
        'canOpenUrl', 'whatsapp://');
  }

  Future<void> sendToWhatsApp() async {
    //whatsapp can be called by system?
    if (!await canSendToWhatsapp()) {
      return throw Exception('Can not send to WhatsApp');
    }

    //number of stickers is ok?
    if (stickers.length < 3 || stickers.length > 30) {
      return throw Exception(
          'Minimum of 3 stickers and maximum of 30 stickers!');
    }
    //call flutter native channel
    await interoperabilityChannel.invokeMethod(
        'sendToWhatsapp', jsonEncode(this));
  }
}

class Sticker {
  String imageData;
  List<String> emojis;

  Sticker({
    this.imageData,
    this.emojis,
  });

  factory Sticker.fromJson(Map<String, dynamic> json) => new Sticker(
        imageData: json["image_data"],
        emojis: new List<String>.from(json["emojis"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "image_data": imageData,
        "emojis": new List<dynamic>.from(emojis.map((x) => x)),
      };
}
