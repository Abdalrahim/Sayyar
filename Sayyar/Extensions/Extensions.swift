//
//  Extensions.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 02/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import Foundation

import SwiftUI

extension String {
    
    var localized: String {
        return NSLocalizedString(self , comment:"")
    }
    
    var localise : LocalizedStringKey {
        return LocalizedStringKey(self)
    }
    
    func localizewithnumber(count: UInt) -> String {
        let resultString : String = String.localizedStringWithFormat(self.localized, count)
        return resultString
    }
    
}

extension UIImage {
    
    var flipped: UIImage {
        guard let cgImage = cgImage else {
            return self
        }
        
        return UIImage(cgImage: cgImage, scale: scale, orientation: .upMirrored)
    }
}

extension UIFont {
    
    func bold(size: CGFloat) -> UIFont {
        return UIFont(name:"Cairo-Bold", size: size)!
    }
    
    func black(size: CGFloat) -> UIFont {
        return UIFont(name:"Cairo-Black", size: size)!
    }
    
    func extralight(size: CGFloat) -> UIFont {
        return UIFont(name:"Cairo-ExtraLight", size: size)!
    }
    
    func light(size: CGFloat) -> UIFont {
        return UIFont(name:"Cairo-Light", size: size)!
    }
    
    func regular(size: CGFloat) -> UIFont {
        return UIFont(name:"Cairo-Regular", size: size)!
    }
    
    func semibold(size: CGFloat) -> UIFont {
        return UIFont(name:"Cairo-SemiBold", size: size)!
    }
}

extension Image {
    func personCircle(diameter : CGFloat) -> Image {
        return self
            .resizable()
            .scaledToFill()
            .frame(width: diameter, height: diameter)
            .cornerRadius(diameter/2) as! Image
    }
}

extension UIDevice {
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
    public class func isSmallScreen() -> Bool {
        return UIScreen.main.nativeBounds.height <= 1334
    }
    var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    enum ScreenType: String {
        case iPhone4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhoneX = "iPhone X"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 1792,2436:
            return .iPhoneX
        default:
            return .unknown
        }
    }
}

extension NSObject {
    func tokenExpired() {
        if let appdelegate =  UIApplication.shared.delegate as? AppDelegate {
            /// Insert Global Element to change the app
            
            
        }
        UserDefaults.standard.removeObject(forKey: SingletonKeys.user.rawValue)
    }
}
