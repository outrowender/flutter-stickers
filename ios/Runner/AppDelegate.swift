import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    //Main function
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    //set controller
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
  
    //create channel
    let interoperabilityChannel = FlutterMethodChannel(name: "interoperabilityChannel", binaryMessenger: controller)

    //call the function
    interoperabilityChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: FlutterResult) -> Void in
        
        
        switch call.method {
        case "canOpenUrl":
            //Call canSend method using bridge
            result(Interoperability.canOpenUrl(url: call.arguments as! String))
            
        case "sendToWhatsapp":
            result(StickerPack.loadFromJson(json: call.arguments as! String))
            
        default:
            result(FlutterMethodNotImplemented)
            return
        }
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

}
