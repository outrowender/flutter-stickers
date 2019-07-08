//
// Copyright (c) WhatsApp Inc. and its affiliates.
// All rights reserved.
//
// This source code is licensed under the BSD-style license found in the
// LICENSE file in the root directory of this source tree.
//

import UIKit

class WebPManager {

    static let shared: WebPManager = WebPManager()

    func isAnimated(webPData data: Data) -> Bool {
        guard let decoder = YYImageDecoder(data: data, scale: 1.0) else {
            return false
        }

        return decoder.frameCount > 1
    }

    func decode(webPData data: Data) -> UIImage? {
        guard let decoder = YYImageDecoder(data: data, scale: 1.0) else {
            return nil
        }

        return decoder.frame(at: 0, decodeForDisplay: true)?.image
    }

    func encode(pngData data: Data) -> Data? {
        guard let encoder = YYImageEncoder(type: YYImageType.webP) else {
            return nil
        }

        encoder.addImage(with: data, duration: 0.0)

        return encoder.encode()
    }
    
    func encodeFromB64(pngBase64 data: String) -> String? {
        guard let encoder = YYImageEncoder(type: YYImageType.webP) else {
            return nil
        }
        
        let dataDecoded : Data = Data(base64Encoded: data, options: .ignoreUnknownCharacters)!
        
        encoder.addImage(with: dataDecoded, duration: 0.0)
        
        guard let encoded = encoder.encode() else {
            return nil
        }
        
        let strBase64 = encoded.base64EncodedString(options: .lineLength64Characters)
        
        print("hold the fileeeee -> ")
        print(strBase64)
        
        return strBase64
    }
}
