import 'dart:convert';
import 'package:flutter/services.dart';

class StickerPack {
  String publisher;
  String trayImage;
  String identifier;
  String name;
  List<Sticker> stickers = [];

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

  //used in conversion to json
  Map toJson() => {
        'publisher': this.publisher,
        'tray_image': this.trayImage,
        'identifier': this.identifier,
        'name': this.name,
        'stickers': this.stickers
      };
}

class Sticker {
  String imageData;
  List<String> emojis;

  Sticker(this.imageData, this.emojis);

  //used in conversion to json
  Map toJson() => {'image_data': imageData, 'emojis': emojis};
}
