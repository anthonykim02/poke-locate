//
//  NSDataExtension.swift
//  pokemonGoAssistant
//
//  Created by Kunal Desai on 7/24/16.
//  Copyright © 2016 anthonykim. All rights reserved.
//

import UIKit

class NSDataExtension: NSData {
    func hexString() -> String{
        let bytes = UnsafeBufferPointer<UInt8>(start: UnsafePointer(self.bytes), count:self.length)
        let hexBytes = map(bytes) { String(format: "%02hhx", $0) }
        return "".join(hexBytes)
    }
}
