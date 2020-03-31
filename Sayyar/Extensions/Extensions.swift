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

