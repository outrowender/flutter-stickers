import UIKit

struct Interoperability {
    private static let DefaultBundleIdentifier: String = "WA.WAStickersThirdParty"
    private static let PasteboardExpirationSeconds: TimeInterval = 60
    private static let PasteboardStickerPackDataType: String = "net.whatsapp.third-party.sticker-pack"
    private static let WhatsAppURL: URL = URL(string: "whatsapp://stickerPack")!

    static var iOSAppStoreLink: String?
    static var AndroidStoreLink: String?

    //Consegue enviar?
    static func canOpenUrl(url: String) -> Bool {
        //return true
        return UIApplication.shared.canOpenURL(URL(string: url)!)
    }
    
    static func sendToWhatsapp(json: String) -> Bool {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            if bundleIdentifier.contains(DefaultBundleIdentifier) {
                fatalError("Your bundle identifier must not include the default one.");
            }
        }

        let pasteboard: UIPasteboard = UIPasteboard.general
        
        if #available(iOS 10.0, *) {
            pasteboard.setItems([[PasteboardStickerPackDataType: json]], options: [UIPasteboardOption.localOnly: true, UIPasteboardOption.expirationDate: NSDate(timeIntervalSinceNow: PasteboardExpirationSeconds)])
        } else {
            pasteboard.setData(json.data(using: .utf8)!, forPasteboardType: PasteboardStickerPackDataType)
        }
        
        DispatchQueue.main.async {
            
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(WhatsAppURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(WhatsAppURL)
                }
            
        }
        return true
    }

    static func copyImageToPasteboard(image: UIImage) {
        UIPasteboard.general.image = image
    }
}
