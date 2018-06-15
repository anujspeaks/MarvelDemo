//
//  ExtensionANUJ.swift
//  Marvelicious
//
//  Created by ANUJ NIGAM on 14/06/18.
//  Copyright © 2018 ANUJ NIGAM. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import MobileCoreServices


let sharedAppdelegate = UIApplication.shared.delegate as! AppDelegate

let isIpad = UIDevice.current.userInterfaceIdiom == .pad
let deviceSize = UIScreen.main.bounds.size

typealias TableViewProtocol = UITableViewDataSource & UITableViewDelegate
typealias AlertAction = (title : String , selector : ((UIAlertAction)->())? , actionStyle : UIAlertActionStyle)

//MARK: Userdefaults
public  func getDefaultObject(forKey key:String) -> Any? {
    return  UserDefaults.standard.object(forKey: key)
}
public func saveDefaultObject(_ object : Any? , forKey:String)
{
    UserDefaults.standard.set(object, forKey: forKey)
    UserDefaults.standard.synchronize()
}
public func removeDefaultObject(forKey:String)
{
    UserDefaults.standard.removeObject(forKey: forKey)
    UserDefaults.standard.synchronize()
}
public func doesContainDefaultObjectForKey(strKey : String) -> Bool {
    if(UserDefaults.standard.object(forKey: strKey) == nil) || (UserDefaults.standard.string(forKey: strKey)) == "" || UserDefaults.standard.string(forKey: strKey) == nil
    {
        return false
    }
    return true
}

extension UIViewController {
    
//    var sharedAppdelegate:AppDelegate {
//        return UIApplication.shared.delegate as! AppDelegate
//    }
    
    @objc public func makeCallOnNumber(number:String) {
        if let url = URL(string: "tel://\(number.replacingOccurrences(of: " ", with: ""))"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        else {
            self.showAlert(withtitle: "Message", message: "Call function not available.")
        }
    }
    public func findLastPresentedViewController() -> UIViewController? {
        func findTopLevelViewController(_ viewController: UIViewController) -> UIViewController? {
            if let vc = viewController.presentedViewController {
                return findTopLevelViewController(vc)
            } else if let vc = viewController as? UISplitViewController  {
                if let vc = vc.viewControllers.last {
                    return findTopLevelViewController(vc)
                }
                return vc
            } else if let vc = viewController as? UINavigationController {
                if let vc = vc.topViewController {
                    return findTopLevelViewController(vc)
                }
                return vc
            } else if let vc = viewController as? UITabBarController {
                if let vc = vc.selectedViewController {
                    return findTopLevelViewController(vc)
                }
                return vc
            } else {
                return viewController
            }
        }
        
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            return findTopLevelViewController(rootViewController)
        }
        
        return nil
    }
}

// MARK: - URL Response Extension
extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}

// MARK: - Color Extension
extension UIColor
{
    var redValue: CGFloat{ return cgColor.components! [0] }
    var greenValue: CGFloat{ return cgColor.components! [1] }
    var blueValue: CGFloat{ return cgColor.components! [2] }
    var alphaValue: CGFloat{ return cgColor.components! [3] }
}
extension NSObject {

    public var colorRed         : UIColor {return UIColor.red}
    public var colorBlack       : UIColor {return UIColor.black}
    public var colorDarkGray    : UIColor {return UIColor.darkGray}
    public var colorLightGray   : UIColor {return UIColor.lightGray}
    public var colorWhite       : UIColor {return UIColor.white}
    public var colorGray        : UIColor {return UIColor.gray}
    public var colorGreen       : UIColor {return UIColor.green}
    public var colorBlue        : UIColor {return UIColor.blue}
    public var colorCyan        : UIColor {return UIColor.cyan}
    public var colorYello       : UIColor {return UIColor.yellow}
    public var colorMegenta     : UIColor {return UIColor.magenta}
    public var colorOrange      : UIColor {return UIColor.orange}
    public var colorPurple      : UIColor {return UIColor.purple}
    public var colorBrown       : UIColor {return UIColor.brown}
    public var colorClear       : UIColor {return UIColor.clear}
    
    public func color(withRed red : Float , green : Float , blue : Float , alpha : Float) -> UIColor
    {
        return UIColor.init(red: CGFloat(red/255.0), green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: CGFloat(alpha))
    }
    func getOpanSansFont(forPointSize size : CGFloat) -> UIFont {
        return UIFont.init(name: "OpenSans", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    func color(fromHex hex : String) -> UIColor {
        var rgbValue : UInt64 = 0
        let scanner = Scanner.init(string: hex)
        scanner.scanLocation = 1
        scanner.scanHexInt64(&rgbValue)
        return color(withRed: (Float((rgbValue & 0xFF0000) >> 16)), green: (Float((rgbValue & 0xFF00) >> 16)), blue: (Float((rgbValue & 0xFF) >> 16)), alpha: 1.0)
    }
}
// MARK: - Notification extension
extension NSObject
{
    public func addNotification(notification name : String , selector : Selector , object : Any? = nil) -> () {
        NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name(rawValue: name), object: object)
    }
    public func removeNotification(notification name : String) -> () {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: name), object: nil)
    }
    public func postNotification(notification name : String , object : Any? = nil) -> () {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: object)
    }
}
// MARK: - Alert extension
extension NSObject
{
    func showAlert(withtitle alerttitle : String? , message : String? , style : UIAlertControllerStyle = .alert , actions : [AlertAction]? = nil)
    {
        let currentStyle = isIpad ? UIAlertControllerStyle.alert : style
        let alert = MarvelAlertController(title: alerttitle?.capitalizingFirstLetter(), message: message?.capitalizingFirstLetter(), preferredStyle: currentStyle)
        if  actions == nil || actions!.isEmpty{
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
        }
        else{
            for action in actions!
            {
                let alertaction = UIAlertAction(title: action.title, style: action.actionStyle, handler: action.selector)
                alert.addAction(alertaction)
            }
        }
        DispatchQueue.main.async {
            if self is UIViewController {
                let vc = self as! UIViewController
                vc.present(alert, animated: true, completion: nil)
            }
            else
            {
                sharedAppdelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    func getAlertAction(for alertTitle : String , selector : ((UIAlertAction) -> ())? = nil , style : UIAlertActionStyle) -> AlertAction
    {
        return (title : alertTitle , selector : selector , actionStyle : style)
    }
}
// MARK: UIView layers extension
extension UIView
{
    func blink() {
        self.alpha = 0.0;
        UIView.animate(withDuration: 0.8, //Time duration you want,
            delay: 0.0,
            options: [.curveEaseInOut, .autoreverse, .repeat],
            animations: { [weak self] in self?.alpha = 1.0 },
            completion: { [weak self] _ in self?.alpha = 0.0 })
    }
    func round()
    {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.height / 2
    }
    func roundedCorner(value : CGFloat , color : UIColor , borderWidth : CGFloat)
    {
        self.clipsToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = value
        self.layer.borderColor = color.cgColor
    }
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

//: UIView Tablecell extension
extension UIView
{
    func indexPathInTableView(tableView : UITableView) -> IndexPath? {
        var view : UIView? = self
        while view != nil {
            if view is UITableViewCell
            {
                return tableView.indexPath(for: view as! UITableViewCell)
            }
            else
            {
                view = view?.superview
            }
        }
        return nil
    }
}

// MARK: String Date extension
extension String
{
    var convertISO8601Date : String {
        let dateformatter = DateFormatter()
        let tempLocale = dateformatter.locale
        dateformatter.locale = Locale(identifier: "en_IN")
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateformatter.date(from: self) else { return "" }
        dateformatter.dateFormat = "MMM dd,yyyy - hh:mm a"
        dateformatter.locale = tempLocale
        return dateformatter.string(from: date)
    }
    var convertDataInMMMddYYYFormat : String {
        
        let dateformatter = DateFormatter()
        let tempLocale = dateformatter.locale
        dateformatter.locale = Locale(identifier: "en_IN")
        dateformatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        guard let date = dateformatter.date(from: self) else { return "" }
        dateformatter.dateFormat = "MMM dd,yyyy - hh:mm a"
        dateformatter.locale = tempLocale
        return dateformatter.string(from: date)
    }
    var convertPeerDateInMMMddYYYFormat : String {
        
        let dateformatter = DateFormatter()
        let tempLocale = dateformatter.locale
        dateformatter.locale = Locale(identifier: "en_IN")
        dateformatter.dateFormat = "dd-MM-yyyy hh:mm:ss a"
        guard let date = dateformatter.date(from: self) else { return "" }
        dateformatter.dateFormat = "MMM dd,yyyy - hh:mm a"
        dateformatter.locale = tempLocale
        return dateformatter.string(from: date)
    }
    
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$!%*?&#])[A-Za-z0-9$@$!%*?&#]{8,20}")
        return passwordTest.evaluate(with: testStr)
    }
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    public func stringSubstring(start: Int, end: Int) -> String
    {
        return "".padding(toLength:end-start, withPad:self, startingAt:start)
    }
    func myMD5String(_ string: String) -> String {
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        //context.deallocate(capacity: 1)
        var hexString = ""
        for byte in digest {
            hexString += String(format:"%02x", byte)
        }
        return hexString
    }
}
// MARK: String HTML reading extension
extension String
{
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString.init(data: data, options: [.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil) else { return nil }
        return html
    }
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    // Returns true if the string has at least one character in common with matchCharacters.
    func containsCharactersIn(matchCharacters: String) -> Bool {
        let charSet = CharacterSet(charactersIn: matchCharacters)
        return self.rangeOfCharacter(from: charSet) != nil
    }
    // Returns true if the string contains only characters found in matchCharacters.
    func containsOnlyCharactersIn(matchCharacters: String) -> Bool {
        let disallowedCharacterSet = CharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
    // Returns true if the string has no characters in common with matchCharacters.
    func doesNotContainCharactersIn(matchCharacters: String) -> Bool {
        let characterSet = CharacterSet(charactersIn: matchCharacters)
        return self.rangeOfCharacter(from: characterSet) == nil
    }
}

// MARK: Date String
extension Date
{
    var convertCurrentDate : String
    {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMM dd,yyyy - hh:mm a"
        return dateformatter.string(from: self)
    }
}
extension UIImage
{
    public func resize(toSize size : CGSize) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect.init(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }
}
// MARK: Custom Loader
//protocol CustomLoader {
//    
//    var customloader : CustomLoader {get}
//}
//extension CustomLoader where Self : UIViewController
//{
//    var customloader : CustomLoader {
//        return Bundle.main.loadNibNamed("CustomLoader", owner: self, options: nil)?.last as! CustomLoader
//    }
//}
// MARK: UITextField
extension UITextField {
    /// set icon of 20x20 with left padding of 8px
    func setLeftIcon(_ icon: UIImage) {
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height+15, height: self.frame.size.height) )
        let iconView  = UIImageView(frame: CGRect(x: 0 , y: 6, width: 25, height: 12))
        iconView.image = icon
        iconView.contentMode = .scaleToFill
        outerView.addSubview(iconView)
        leftView = outerView
        leftViewMode = .always
    }
}
// MARK: UILabel
extension UILabel {
    func halfTextColorChange (fullText : String , changeText : String, textColor : UIColor ) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: textColor , range: range)
        self.attributedText = attribute
    }
}
extension UIFont {
    func systemFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
    func italicSystemFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Italic", size: size)!
    }
    
    func boldSystemFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
    
    func mediumSystemFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
    
    func lightSystemFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: size)!
    }
    
    func thinSystemFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Thin", size: size)!
    }
    
    func ultraLightSystemFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-UltraLight", size: size)!
    }
    
    //    func preferredFontForTextStyle(style: NSString) -> UIFont {
    //        switch style {
    //        case UIFontTextStyle.body as UIFontTextStyle:
    //            return UIFont.systemFont(ofSize: 15)
    //        case UIFontTextStyle.headline as UIFontTextStyle:
    //            return UIFont.lightSystemFontOfSize(30)
    //        case UIFontTextStyleSubheadline:
    //            return UIFont.lightSystemFontOfSize(17)
    //        case UIFontTextStyleFootnote:
    //            return UIFont.systemFontOfSize(13)
    //        case UIFontTextStyleCaption1:
    //            return UIFont.systemFontOfSize(12)
    //        case UIFontTextStyleCaption2:
    //            return UIFont.systemFontOfSize(11)
    //        default:
    //            return UIFont.systemFontOfSize(15)
    //        }
    //    }
}


