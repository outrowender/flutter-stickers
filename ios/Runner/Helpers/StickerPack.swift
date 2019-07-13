// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - StickerPack
struct StickerPack: Codable {
    let iosAppStoreLink, androidPlayStoreLink: String?
    let identifier, name, publisher, tray_image: String
    var stickers: [Sticker]
    
    enum CodingKeys: String, CodingKey {
        case iosAppStoreLink, androidPlayStoreLink
        case identifier, name, publisher, tray_image
        case stickers
    }
    
    static func loadFromJson(json: String) -> Bool {
        let jsonData = json.data(using: .utf8)
        let decoder = JSONDecoder()
        var pack = try! decoder.decode(StickerPack.self, from: jsonData!)
        
        for (index, item) in pack.stickers.enumerated() {
            pack.stickers[index].image_data = WebPManager.encodeFromB64(pngBase64: item.image_data)!
            print(index, "ok")
        }
        
        //encode again
        let jsonDataOut = try! JSONEncoder().encode(pack)
        let jsonString = String(data: jsonDataOut, encoding: .utf8)!
        
        return Interoperability.sendToWhatsapp(json: jsonString)
        
    }
}

// MARK: - Sticker
struct Sticker: Codable {
    var image_data: String
    let emojis: [String]
    
    enum CodingKeys: String, CodingKey {
        case image_data
        case emojis
    }
}
