//
//  L102Language.swift
//  Localization102
//
//  Created by Moath_Othman on 2/24/16.
//  Copyright © 2016 Moath_Othman. All rights reserved.
//

import UIKit

// constants
let APPLE_LANGUAGE_KEY = "AppleLanguages"

/// L102Language

class L102Language {
    
    
    /// get current Apple language
    class func currentAppleLanguage() -> String {
        
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        let endIndex = current.startIndex
        let currentWithoutLocale = current.substring(to: current.index(endIndex, offsetBy: 2))
        return currentWithoutLocale
    }
    
    class func currentAppleLanguageFull() -> String {
        
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        
        return current
    }
    
    /// set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        
        userdef.synchronize()
    }
    
    
    class var isRTL : Bool {
        
        return L102Language.currentAppleLanguage() == "ar"
    }
    
    class var localeIdentifier: String {
        return isRTL ? "ar_DZ" : "en"
    }
}

func MethodSwizzleGivenClassName1(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    
    guard let origMethod: Method = class_getInstanceMethod(cls, originalSelector) else {return}
    
   guard let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector) else {return}
    
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod))
        
    } else {
        
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}




extension Bundle {
    
    @objc func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        
        if self == Bundle.main {
            
            let currentLanguage = L102Language.currentAppleLanguage()
            var bundle = Bundle();
            
            if let _path = Bundle.main.path(forResource: L102Language.currentAppleLanguageFull(), ofType: "lproj") {
                
                bundle = Bundle(path: _path)!
                
            }else if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                    
                    bundle = Bundle(path: _path)!
                
                } else {
                
                    let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
                    bundle = Bundle(path: _path)!
            }
            
            return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
            
        } else {
            
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
        }
    }
}

class L102Localizer: NSObject {
    
    class func DoTheMagic() {
        
        MethodSwizzleGivenClassName1(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
        
//        MethodSwizzleGivenClassName1(cls: UIApplication.self, originalSelector: #selector(getter: UIApplication.userInterfaceLayoutDirection), overrideSelector: #selector(getter: UIApplication.cstm_userInterfaceLayoutDirection))
//
//
//        MethodSwizzleGivenClassName1(cls: UITextField.self, originalSelector: #selector(UITextField.layoutSubviews), overrideSelector: #selector(UITextField.cstmlayoutSubviews))
//
//        MethodSwizzleGivenClassName1(cls: UILabel.self, originalSelector: #selector(UILabel.layoutSubviews), overrideSelector: #selector(UILabel.cstmlayoutSubviews))
    }
    
    class func DoMagic(){
        
    }
}


extension UIApplication {
    
    var cstm_userInterfaceLayoutDirection : UIUserInterfaceLayoutDirection {
        
        get {
            
            var direction = UIUserInterfaceLayoutDirection.leftToRight
            
            if L102Language.currentAppleLanguage() == "ar" {
                
                direction = .rightToLeft
            }
            return direction
        }
    }
}

extension UILabel {
    
    public func cstmlayoutSubviews() {
        
        self.cstmlayoutSubviews()
        if self.isKind(of: NSClassFromString("UITextFieldLabel")!) {
            return // handle special case with uitextfields
        }
        if self.tag <= 0  {
            if UIApplication.isRTL()  {
                if self.textAlignment == .right {
                    return
                }
            } else {
                if self.textAlignment == .left {
                    return
                }
            }
        }
        if self.tag <= 0 {
            
            if UIApplication.isRTL()  {
                
                self.textAlignment = .right
                
            } else {
                
                self.textAlignment = .left
                
            }
        }
    }
}

extension UITextField {
    
    public func cstmlayoutSubviews() {
        
        self.cstmlayoutSubviews()
        
        if self.tag <= 0 {
            
            if UIApplication.isRTL()  {
                
                if self.textAlignment == .right { return }
                self.textAlignment = .right
                
            } else {
                
                if self.textAlignment == .left { return }
                self.textAlignment = .left

            }
        }
    }
}

extension UIApplication {
    
    class func isRTL() -> Bool{
        
        return L102Language.isRTL
    }
}




class ButtonRTLSupported: UIButton {
    
    @IBInspectable var contentInsetLeftRTL:CGFloat = 0
    @IBInspectable var contentInsetBottomRTL:CGFloat = 0
    @IBInspectable var contentInsetTopRTL:CGFloat = 0
    @IBInspectable var contentInsetRightRTL:CGFloat = 0
    
    @IBInspectable var titleInsetLeftRTL:CGFloat = 0
    @IBInspectable var titleInsetBottomRTL:CGFloat = 0
    @IBInspectable var titleInsetTopRTL:CGFloat = 0
    @IBInspectable var titleInsetRightRTL:CGFloat = 0
    
    @IBInspectable var imageInsetLeftRTL:CGFloat = 0
    @IBInspectable var imageInsetBottomRTL:CGFloat = 0
    @IBInspectable var imageInsetTopRTL:CGFloat = 0
    @IBInspectable var imageInsetRightRTL:CGFloat = 0
    
    @IBInspectable var flipImage:Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLayout()
    }
    
    
    func setLayout(){
        
        if L102Language.isRTL {
            
            //            if self.contentMode == .left || self.contentMode == .right{
            //                self.contentMode = self.contentMode == .left ? .right : .left
            //            }
            //
            if self.imageView?.image != nil && flipImage{
                
                let flippedImage = UIImage.init(cgImage: (self.image(for: .normal)?.cgImage!)!, scale: (self.image(for: .normal)?.scale)!, orientation: UIImage.Orientation.upMirrored)
                
                self.setImage(flippedImage, for: .normal)
            }
            
            
            self.contentEdgeInsets = UIEdgeInsets(top: contentInsetTopRTL, left: contentInsetLeftRTL, bottom: contentInsetBottomRTL, right: contentInsetRightRTL)
            self.titleEdgeInsets = UIEdgeInsets(top: titleInsetTopRTL, left: titleInsetLeftRTL, bottom: titleInsetBottomRTL, right: titleInsetRightRTL)
            self.imageEdgeInsets = UIEdgeInsets(top: imageInsetTopRTL, left: imageInsetLeftRTL, bottom: imageInsetBottomRTL, right: imageInsetRightRTL)
            
        }
    }
}

class ImageViewRTLSupported: UIImageView {
    

    @IBInspectable var flipImage:Bool = true
    @IBInspectable var imageRTL:UIImage? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLayout()
    }
    
    
    func setLayout(){
        
        if L102Language.isRTL {
            
            if self.image != nil && flipImage{
                
                self.image = self.image?.flipped
                
            }else if imageRTL != nil{
                
                self.image = imageRTL
                
            }
            
        }
    }
}
