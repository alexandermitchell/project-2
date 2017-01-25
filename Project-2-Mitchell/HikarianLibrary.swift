
//  HikarianLibrary.swift
//
//  Created by Hikarus on 14/06/01.
//  Copyright (c) 2014 Hikarian. All rights reserved.
//

/* VARIABLE TYPE SUFFIX CRITERION

   Boolean              ⓑ
   String               $
   number               ＃
   Int                  ＃i
   Float                ＃f
   Double               ＃d
   CGFloat              ⓖ
   CGPoint              ⓖ²    2 dimensional CGFloats
   CGRect               ⓖ⁴    4 dimensional CGFloats
   Binary/Data          ß     For NSData, and images or videos in CoreDa
   UIImage              ⓘ
   CoreImage            Ⓘ
   NSDate               ㊐
   Reference Type       ＆  Instance of a class
   Tuple                🅣
   Array                🅐
   Set                  ...     ? not sure about this one...
   Dictionary           🅓
   Enumeration          🅔
   Structure            🅢
   Library Class        ＋
   Complex Structure    ﹙﹚
   Undetermined         ﹖     for Uudetermined types: Optional or AnyObject
   Implicitly unwrapped ﹗
   Protocol             Ⓟ
   Function             ƒ
   Pointer              ⓟ⃗
   PhotoAsset           ⓐ
   Collection           🅒
   WRAPPER/DYNAMIC      🅆  (Alt + Shift + W)
   DB Root              🅁
   DB Branch            🄱
   IBOutlets            ﹫
   mutating functions   🇲
 
*/

import Foundation
import UIKit
import Photos
import CoreData
import MapKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}



// MARK: EXPERIMENTAL —————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————


// CoreImage objects have suffix ⓘ?
//let ciContext = CIContext(options: nil) // these filter clasess must be initialized at boot 'cos they are processor consumming and would delay the UI flow
//let gaussianBlurFilter = CIFilter(name: "CIGaussianBlur", withInputParameters: nil)!
//let colorControlFilter = CIFilter(name: "CIColorControls", withInputParameters: nil)! // inputParameters: [String : AnyObject]? 例: ["inputImage": inImage, "inputSaturation": 0.5, inputBrightness: 1.2, inputContrast: 1.3]
//func gaussianBlur() {
//   let rasterUIImage = exitingSceneUIElements[0].rasterizedToImage
//   let blurRadius: CGFloat = 12
//   gaussianBlurFilter.setValue(CIImage(image: rasterUIImage), forKey: kCIInputImageKey); gaussianBlurFilter.setValue(blurRadius, forKey: kCIInputRadiusKey) // must use CIImage(image: rasterUIImage) because rasterUIImage.CIImage produces nil ( => not working)
//   let filteredCGImage: CGImage = ciContext.createCGImage(gaussianBlurFilter.outputImage!, fromRect: gaussianBlurFilter.outputImage!.extent)
//
//   // seems that the gaussian blur margin is (blurRadius, blurRadius, width - blurRadius*2, height - blurRadius * 2)
//
//   let croppedFilteredCGImage = CGImageCreateWithImageInRect(filteredCGImage, CGRectMake(blurRadius, blurRadius, CGFloat(CGImageGetWidth(filteredCGImage))  - blurRadius*10, CGFloat(CGImageGetHeight(filteredCGImage))  - blurRadius*2))!
//
//   let filteredUIImageView = UIImageView(image: UIImage(CGImage: croppedFilteredCGImage))
//   filteredUIImageView.setFrame(width: sceneW, height: sceneH)
//   view.addSubview(filteredUIImageView)
//   view.bringSubviewToFront(filteredUIImageView)
//}

/*

FILTERS:  CIBumpDistortion, CIGaussianBlur, CIPixellate, CISepiaTone, CITwirlDistortion, CIUnsharpMask, CIVignette

FILTER PARAMETERS: kCIOutputImageKey, kCIInputBackgroundImageKey, kCIInputImageKey, kCIInputTimeKey, kCIInputTransformKey, kCIInputScaleKey, kCIInputAspectRatioKey, kCIInputCenterKey, kCIInputRadiusKey, kCIInputAngleKey, kCIInputRefractionKey, kCIInputWidthKey, kCIInputSharpnessKey, kCIInputIntensityKey, kCIInputEVKey, kCIInputSaturationKey, kCIInputColorKey, kCIInputBrightnessKey, kCIInputContrastKey, kCIInputBiasKey, kCIInputWeightsKey, kCIInputGradientImageKey, kCIInputMaskImageKey, kCIInputShadingImageKey, kCIInputTargetImageKey, kCIInputExtentKey, kCIInputVersionKey

*/

// MARK: PROTOCOLS —————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

protocol HasContextID$Ⓟ { var contextID$: String? { get set } }
protocol HasContextualInfo$Ⓟ { var contextualInfo$: String? { get set } }
protocol HasCoordinates$Ⓟ { var x$: String? { get set } ; var y$: String? { get set } }

// MARK: GENERAL VARIABLES —————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
var keyboardHeightⓖ = CGFloat() // this value is assigned by the return of the function slideForKeyboardAndReturnOffset() at Hikarian Library, so it automaticall adapts to the screen size
var keyboardIsUpⓑ = false
let specialCharacters$🅐 = ["∞"]
let YES = true, NO = false ; let 𝟭 = true, 𝟘 = false
let app＆ = UIApplication.shared
let appWindow＆ = app＆.windows[0]
let fileManager＆ = FileManager.default
let notificationCenter＆ = NotificationCenter.default
var applicationPath$: String { return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] }
let menuController＆ = UIMenuController.shared

enum ButtonStateTypes🅔 {
   case enabled
   case disabled
   case current
}

var Δ = 0

// MARK: CUSTOM OPERATORS ————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————



prefix operator √ // ⌥V : can be used just √X without ()
prefix func √ (number: Double) -> Double { return sqrt(number) }

prefix operator ¬ // ⌥6
prefix func ¬ (expressionⓑ: Bool) -> Bool { return !expressionⓑ }

prefix operator ◊ // ⬆︎⌥V - Need to find a better character for this
prefix func ◊<T> (object＆: T?) -> Bool { return object＆ == nil ?  false : YES }

prefix operator • // ⬆︎ + ⌥ + 3
prefix func •<T> (pointer: UnsafeMutablePointer<T>) -> T { return pointer.pointee }

/* MUST RESEARCH ABOUT PRECEDENCE GROUPS. The group names are nowhere to be found
 
 //precedencegroup PowerPrecedence {
 //   associativity: left
 //   higherThan:
 //}
 
infix operator ** { associativity left precedence 160 } // ⬆︎⌥D
func **(base＃: Double, power＃: Double) -> Double { return pow(base＃, power＃) }

infix operator ‡{ precedence 130 } // ⬆︎⌥T
func ‡<T: Equatable> (object1: T, object2: T) -> Bool { return object1 != object2 }

infix operator ~ { associativity left precedence 160 } // ⌥Ñ
func ~<T> (pointer: UnsafeMutablePointer<T>, newValue: T ) { pointer.pointee = newValue }
func pointerTo<T>(_ object＆: inout T) -> UnsafeMutablePointer<T> { return withUnsafeMutablePointer(to: &object＆) {UnsafeMutablePointer<T>($0) } } // THIS FUNCTION IS T-H-E • S-H-I-T!!  TOOK ME SOME TIME TO FIGURE OUT, but now I can get a pointer to a value-type!! 😀👍🏼👋🏻 (must post-cast)

*/

// MAR: INTERNAL & TYPE EXTENSIONS ————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

extension Optional {
   func isNotNilⓑ() -> Bool { return self != nil }
   func isNilⓑ() -> Bool { return self == nil }
   mutating func setNil() { self = nil }
}

extension Int {
   static func random＃(_ min＃: Int = 0, max＃: Int) -> Int { return Int(arc4random_uniform(UInt32((max＃ - min＃) + 1))) + min＃ }
   var years＃㊐🅣: (unit㊐: NSCalendar.Unit, value＃: Int) { return (NSCalendar.Unit.year, self) }
   var months＃㊐🅣: (unit㊐: NSCalendar.Unit, value＃: Int) { return (NSCalendar.Unit.month, self) }
   var days＃㊐🅣: (unit㊐: NSCalendar.Unit, value＃: Int){ return (NSCalendar.Unit.day, self) }
   var hours＃㊐🅣: (unit㊐: NSCalendar.Unit, value＃: Int)  { return (NSCalendar.Unit.hour, self) }
   var minutes＃㊐🅣: (unit㊐: NSCalendar.Unit, value＃: Int) { return (NSCalendar.Unit.minute, self) }
   var seconds＃㊐🅣: (unit㊐: NSCalendar.Unit, value＃: Int)  { return (NSCalendar.Unit.second, self) }
   var countToIndex＃: Int { return self - 1 }
   var indexToCount＃: Int { return self + 1 }
   var evenⓑ: Bool { return self % 2 == 0 }
   var oddⓑ: Bool { return self % 2 != 0 }
   var formattedWith2Digits$: String { get { return String(format: "%02d", self) } }
   func isMultipleOfⓑ(_ number＃: Int) -> Bool { return self % number＃ == 0 }
   func isMultipleOfⓑ(_ number＃: Float) -> Bool { return Float(self).truncatingRemainder(dividingBy: number＃) == 0 }
   func isMultipleOfⓑ(_ number＃: CGFloat) -> Bool { return CGFloat(self).truncatingRemainder(dividingBy: number＃) == 0 }
   func isMultipleOfⓑ(_ number＃: Double) -> Bool { return Double(self).truncatingRemainder(dividingBy: number＃) == 0 }
}

extension Float {
   var isIntegerⓑ: Bool { return self - Float(Int(self)) == 0 }
   var formattedWith2Decimals$: String {
      let twoDecimalsFormatter = NumberFormatter()
      twoDecimalsFormatter.numberStyle = NumberFormatter.Style.decimal
      twoDecimalsFormatter.minimumFractionDigits = 2 ; twoDecimalsFormatter.maximumFractionDigits = 2
      return twoDecimalsFormatter.string(from: NSNumber(value: self))!
   }
   func truncate$(numberOfDecimals＃: Int) -> String {
      let twoDecimalsFormatter = NumberFormatter()
      twoDecimalsFormatter.numberStyle = NumberFormatter.Style.decimal
      twoDecimalsFormatter.minimumFractionDigits = numberOfDecimals＃ ; twoDecimalsFormatter.maximumFractionDigits = numberOfDecimals＃
      return twoDecimalsFormatter.string(from: NSNumber(value: self))!
   }
   func isMultipleOfⓑ(_ number＃: Int) -> Bool { return self.truncatingRemainder(dividingBy: Float(number＃)) == 0 }
   func isMultipleOfⓑ(_ number＃: Float) -> Bool { return self.truncatingRemainder(dividingBy: number＃) == 0 }
   func isMultipleOfⓑ(_ number＃: CGFloat) -> Bool { return CGFloat(self).truncatingRemainder(dividingBy: number＃) == 0 }
   func isMultipleOfⓑ(_ number＃: Double) -> Bool { return Double(self).truncatingRemainder(dividingBy: number＃) == 0 }
}

extension CGFloat {
   var isIntegerⓑ: Bool { return self - CGFloat(Int(self)) == 0 }
   var absoluteValueⓖ: CGFloat { return self > 0 ? self : -self }
   static func random(_ max＃: Int) -> CGFloat { return CGFloat(arc4random() % UInt32(max＃)) }
   var formattedWith2Decimals$: String {
      let twoDecimalsFormatter = NumberFormatter()
      twoDecimalsFormatter.numberStyle = NumberFormatter.Style.decimal
      twoDecimalsFormatter.minimumFractionDigits = 2 ; twoDecimalsFormatter.maximumFractionDigits = 2
      return twoDecimalsFormatter.string(from: NSNumber(value: Float(self)))!
   }
   func truncate$(numberOfDecimals＃: Int) -> String {
      let twoDecimalsFormatter = NumberFormatter()
      twoDecimalsFormatter.numberStyle = NumberFormatter.Style.decimal
      twoDecimalsFormatter.minimumFractionDigits = numberOfDecimals＃ ; twoDecimalsFormatter.maximumFractionDigits = numberOfDecimals＃
      return twoDecimalsFormatter.string(from: NSNumber(value: Float(self)))!
   }
   func isMultipleOfⓑ(_ number＃: Int) -> Bool { return self.truncatingRemainder(dividingBy: CGFloat(number＃)) == 0 }
   func isMultipleOfⓑ(_ number＃: Float) -> Bool { return self.truncatingRemainder(dividingBy: CGFloat(number＃)) == 0 }
   func isMultipleOfⓑ(_ number＃: CGFloat) -> Bool { return self.truncatingRemainder(dividingBy: number＃) == 0 }
   func isMultipleOfⓑ(_ number＃: Double) -> Bool { return Double(self).truncatingRemainder(dividingBy: number＃) == 0 }
}

extension Double {
   var isIntegerⓑ: Bool { return self - Double(Int(self)) == 0 }
   var formattedWith2Decimals$: String {  // must investigate combining this with fixed digit in number as well
      let twoDecimalsFormatter = NumberFormatter()
      twoDecimalsFormatter.numberStyle = NumberFormatter.Style.decimal
      twoDecimalsFormatter.minimumFractionDigits = 2 ; twoDecimalsFormatter.maximumFractionDigits = 2
      return twoDecimalsFormatter.string(from: NSNumber(value: Float(self)))!
   }
   func truncate$(numberOfDecimals＃: Int) -> String {
      let twoDecimalsFormatter = NumberFormatter()
      twoDecimalsFormatter.numberStyle = NumberFormatter.Style.decimal
      twoDecimalsFormatter.minimumFractionDigits = numberOfDecimals＃ ; twoDecimalsFormatter.maximumFractionDigits = numberOfDecimals＃
      return twoDecimalsFormatter.string(from: NSNumber(value: Float(self)))!
   }
   func isMultipleOfⓑ(_ number＃: Int) -> Bool { return self.truncatingRemainder(dividingBy: Double(number＃)) == 0 }
   func isMultipleOfⓑ(_ number＃: Float) -> Bool { return self.truncatingRemainder(dividingBy: Double(number＃)) == 0 }
   func isMultipleOfⓑ(_ number＃: CGFloat) -> Bool { return CGFloat(self).truncatingRemainder(dividingBy: number＃) == 0 }
   func isMultipleOfⓑ(_ number＃: Double) -> Bool { return self.truncatingRemainder(dividingBy: number＃) == 0 }
}

extension CGRect { // this shortens A LOT the code for editing CGRects * * * *
   
   mutating func setValuesⓖ⁴(xⓖ: CGFloat? = nil, ＋Xⓑ: Bool = false, yⓖ: CGFloat? = nil, ＋Yⓑ: Bool = false, widthⓖ: CGFloat? = nil, ＋Wⓑ: Bool = false, heightⓖ: CGFloat? = nil, ＋Hⓑ: Bool = false) {
      var _xⓖ: CGFloat, _yⓖ: CGFloat, _widthⓖ : CGFloat, _heightⓖ: CGFloat
      _xⓖ = xⓖ.isNilⓑ() ? origin.x : ( ＋Xⓑ ? origin.x + xⓖ! : xⓖ! )
      _yⓖ = yⓖ.isNilⓑ() ? origin.y : ( ＋Yⓑ ? origin.y + yⓖ! : yⓖ! )
      _widthⓖ = widthⓖ.isNilⓑ() ? width : ( ＋Wⓑ ? width + widthⓖ! : widthⓖ! )
      _heightⓖ = heightⓖ.isNilⓑ() ? height : ( ＋Hⓑ ? height + heightⓖ! : heightⓖ! )
      self = CGRect(x: _xⓖ, y: _yⓖ, width: _widthⓖ, height: _heightⓖ)
   }
   
   mutating func setMarginⓖ⁴(marginⓖ: CGFloat) { setValuesⓖ⁴(xⓖ: marginⓖ, ＋Xⓑ: YES, yⓖ: marginⓖ, ＋Yⓑ: YES, widthⓖ: -(2*marginⓖ), ＋Wⓑ: YES, heightⓖ: -(2*marginⓖ), ＋Hⓑ: YES) }
   
   func withMarginⓖ⁴(marginⓖ: CGFloat) -> CGRect {
      var outputⓖ⁴ = CGRect(x: self.origin.x, y: self.origin.y, width: self.width, height: self.height)
      outputⓖ⁴.setValuesⓖ⁴(xⓖ: marginⓖ, ＋Xⓑ: YES, yⓖ: marginⓖ / 2, ＋Yⓑ: YES, widthⓖ: -(2*marginⓖ), ＋Wⓑ: YES, heightⓖ: -marginⓖ, ＋Hⓑ: YES)
      return outputⓖ⁴
   }
}

internal extension Array {

   var isNotEmptyⓑ: Bool { return !isEmpty }
   var lastIndex＃: Int { return count == 0 ? count : count - 1 }
 
   var second: Element? { return self[1] }
   var third: Element?  { return self[2] }
   var lastElement: Element? {
      get { return last }
      set { self[lastIndex＃] = newValue! }
   }
   var penultimate: Element? {
      if count > 1 { return self[lastIndex＃ - 1] }
      return nil
   }
   
   subscript(start＃: Int, end＃: Int) -> Array<Element> {
      let maxEnd＃ = [lastIndex＃, end＃].min()
      var output🅐: Array<Element> = []
      for index＃ in 0...maxEnd＃! { output🅐.append(self[index＃]) }
//      for var index＃ = 0 ; index＃ <= maxEnd＃ ; index＃ += 1 { output🅐.append(self[index＃]) }
      return output🅐
   }

   mutating func clear() { removeAll() }
   mutating func pushElement(_ element: Element) { append(element) }
   mutating func popElement() -> Element { return removeLast() }
   mutating func popElements(numberOfElements＃: Int, FIFOⓑ: Bool = false) -> [Element] {
      var output🅐 = [Element](); var counter = 1
      for element﹖ in reversed() {
         output🅐.append(element﹖)
         counter += 1; if counter > numberOfElements＃ { break }
      }
      return FIFOⓑ ? output🅐.reversed() : output🅐
   }
   mutating func removeLast(numberOfElements＃: Int) { for _ in 1...numberOfElements＃ { removeLast() } }
   mutating func pluck(atIndex itemIndex＃: Int = 0) -> Element { return remove(at: itemIndex＃) }
   func last·n·Elements🅐(numberOfElements＃: Int) -> [Element] {
      var outputArray🅐 = [Element]()
      for elementIndex＃ in (count - numberOfElements＃)..<count { outputArray🅐.append(self[elementIndex＃]) }
//      for (var elementIndex＃ = count - numberOfElements＃ ; elementIndex＃ < count ; elementIndex＃++) { outputArray🅐.append(self[elementIndex＃]) }
      return outputArray🅐
   }
   // func pickRandomElement() -> Element
   // func pluckRandomElement() -> Element


   func elemetsContaingString＃<T>(string$: String, segment＃＃🅣: (start＃: Int, end＃: Int)? = nil, componentNumberOrFirstOrLast﹖: T? = nil) -> Int? { // only for [String]
      if count == 0 { return 0 }
      if !(HK＋.getTypeName$(self) == "Array<String>") { return nil } // cutre way to check for Array Type
      var counter＃ = 0
      if segment＃＃🅣 == nil {
         for element﹖ in self {
            let element$ = element﹖ as! String
            if element$.range(of: string$) != nil { counter＃ += 1 }
         }
      } else {
         if componentNumberOrFirstOrLast﹖.isNilⓑ() {
            for element﹖ in self {
               let element$ = element﹖ as! String
               if element$[segment＃＃🅣!.start＃, segment＃＃🅣!.end＃] == string$ { counter＃ += 1 }
            }
         } else {
            switch HK＋.getTypeName$(componentNumberOrFirstOrLast﹖!) {
               case "Int":
                  for element﹖ in self {
                     let element$ = element﹖ as! String
                     let elementComponent$ = element$.components(separatedBy: ".")[componentNumberOrFirstOrLast﹖ as! Int]
                     if elementComponent$[segment＃＃🅣!.start＃, segment＃＃🅣!.end＃] == string$ { counter＃ += 1 }
                  }
               case "String":
                  for element﹖ in self {
                     let element$ = element﹖ as! String
                     var elementComponent$: String
                        switch (componentNumberOrFirstOrLast﹖ as! String).lowercased().trimmed$ {
                           case "first": elementComponent$ = element$.components(separatedBy: ".").first!
                           case "last": elementComponent$ = element$.components(separatedBy: ".").last!
                           default: return nil
                      }
                     if elementComponent$[segment＃＃🅣!.start＃, segment＃＃🅣!.end＃] == string$ { counter＃ += 1 }
                  }
               default: return nil
            }
         }
      }
      return counter＃
   }
   
}

extension PHFetchResult {
   var isEmptyⓑ: Bool { return count == 0 }
   var isNotEmptyⓑ: Bool { return count != 0 }
}


internal extension Dictionary { mutating func clear() { removeAll() } }

extension Character {
   
   var isDecDigitⓑ: Bool { return self >= "0" && self <= "9" }
   var isHexDigitⓑ: Bool { return isDecDigitⓑ || (self >= "a" && self <= "f") || (self >= "A" && self <= "F") }
   
   // This is a way to obtain the ASCII code of a single-character string, but it's not needed to evaluate a character with operators < and >
   // let charUnicodeScalar = String(char).lowercaseString.unicodeScalars
   // var digitASCIICode = charUnicodeScalar[charUnicodeScalar.startIndex].value
   
}


extension String {

   static func spaces$(_ length＃: Int) -> String {
      if length＃ == 0 { return "" }
      var spaces$ = ""
      for _ in 1...length＃ { spaces$ += " " }
      return spaces$
   }
   
   var isEmptyⓑ: Bool { return self == "" }
   var characters＃: Int { return characters.count }
   var length＃: Int { return characters＃ }
   var lastIndex＃: Int  { return characters＃ == 0 ? characters＃ : characters＃ - 1 }
   var lastCharacter$: String { return self == "" ? "" : self[self.lastIndex＃]! }
   
   
   subscript(index＃: Int) -> String? { // Ret -> String? urns the character at the index
      if length＃ == 0 { return nil }
      return substring(with: Range(uncheckedBounds: (lower: index(startIndex, offsetBy: index＃), upper: index(startIndex, offsetBy: index＃ + 1))))
   }
   
   subscript(start＃: Int, end＃: Int) -> String? { // Returns the substring in the given Int range. Max-overflow-proof
      if start＃ < 0 || start＃ > [lastIndex＃, end＃].min()! { return nil }
      let startIndex＃ = index(startIndex, offsetBy: start＃)
      let endIndex＃ = index(startIndex, offsetBy: end＃ + 1)
      return substring(with: Range(uncheckedBounds: (lower: startIndex＃, upper: endIndex＃)))
   }
   
   
   func left$(_ length＃: Int) -> String { if length＃ <= length＃ { return self[0, length＃-1]! } else { return self } }
   func right$(_ length＃: Int) -> String { if length＃ <= length＃ { return self[length＃ - length＃, length＃-1]! } else { return self } }
   
   var localized$: String { return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "") }
   var capitalizedFirst$: String  { return String(characters.prefix(1)).uppercased() + String(characters.dropFirst()) }
   mutating func capitalizeFirst() { replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).uppercased()) }
   var capitalizedAfterCommas$: String {
      var output$ = String()
      let componentsMaxIndex＃ = self.components(separatedBy: ",").lastIndex＃
      for (index＃, component$) in self.components(separatedBy: ",").enumerated() {
         let trimmedComponent$ = component$.trimmed$.capitalizedFirst$
         output$ += trimmedComponent$ + (index＃ == componentsMaxIndex＃ ? "" : ", ")
      }
      return output$
   }
   
   
   var trimmed$: String { return (self as NSString).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
   func removeCharacter$(_ character$: String) -> String { return trimmingCharacters(in: CharacterSet(charactersIn: character$)) }
   func replaceCharacter$(_ out$: String, new$: String) -> String { return replacingOccurrences(of: out$, with: new$) }
   func insertCharacters$(_ characters$: String, interval＃: Int) -> String {
      var output$ = ""
      for (characterIndex＃, character$) in characters.enumerated()  {
         output$ += String(character$)
         if (characterIndex＃ - 1).isMultipleOfⓑ(interval＃) && characterIndex＃ != characters.count - 1 { output$ += characters$ }
      }
      return output$
   }

   var droppedLastCharacter$: String { return self[length＃ - 2]! }
   var droppedFirstCharacter$: String { return self[1, length＃]! }
   func replaceCharacters$(atIndex＃ index＃: Int, numberOfCharacters＃: Int = 0, newCharacters$: String) -> String? {
      if index＃ > lastIndex＃ || index＃ + numberOfCharacters＃ > lastIndex＃ { return nil }
      return self[0, index＃ - newCharacters$.length＃ + 1]! + newCharacters$ + self[index＃ + newCharacters$.length＃, self.length＃]!
   }
   
   var toDate㊐: Date { let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "YYYY/MM/dd"; return dateFormatter.date(from: self)! }
   var toTime㊐: Date { let timeFormatter = DateFormatter(); timeFormatter.dateFormat = "HH:mm"; return timeFormatter.date(from: self)! }
   var yearComponent$: String? { // takes format "YYYY/MM/DD"
      if length＃ != 10 { return nil }
      return self[0, 3]
   }
   var monthComponent$: String? { // takes format "YYYY/MM/DD"
      if length＃ != 10 { return nil }
      return self[5, 6]
   }
   var dayComponent$: String? { // takes format "YYYY/MM/DD"
      if length＃ != 10 { return nil }
      return self[8, 9]
   }
   func isWeekEndⓑ() -> Bool { if HKDate＋.WeekDayFromLocalizedString$🅔🅓[self] == .saturday || HKDate＋.WeekDayFromLocalizedString$🅔🅓[self] == .sunday { return true } else { return false } }
   func isWeekDayⓑ() -> Bool { if isWeekEndⓑ() { return false } else { return true } }

   var int＃: Int? { return Int(self) ?? nil }
   var double＃: Double? { return Double(self) ?? nil }
   var float＃: Float? { return Float(self) ?? nil }
   var CGFloatⓖ: CGFloat? { return float＃.isNilⓑ() ? nil : CGFloat(float＃!) }
   var intFromHexString＃: Int? { // gets a string representing an hexadecimal number in the standard format 0x0000..., and returns its Integer value
      let hexDigits$🅓 = ["0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "A": 10, "B": 11, "C": 12, "D": 13, "E": 14, "F": 15]
      func formatIsCorrectⓑ() -> Bool {
         var veredictⓑ: Bool = true
         for char$ in characters { if !char$.isHexDigitⓑ { veredictⓑ = false ; break } }
         return veredictⓑ
      }
      let return＃ = hexDigits$🅓[self[0]!]! * 16 + hexDigits$🅓[self[1]!]!
      return formatIsCorrectⓑ() ? return＃ : nil
   }
   func toChar$ (_ position＃: Int = 0) -> Character? { return position＃ > length＃ - 1 ? nil : Character(self[position＃]!) } // returns the requested character in a string converted to type Character

   var components$🅐: [String] { return components(separatedBy: ".") }
   var firstComponent$: String? { return components(separatedBy: ".").first }
   var lastComponent$: String? { return components(separatedBy: ".").last }
   
}

//   var GPX㊐: NSDate? { // GPS Exchange format
//      let dateFormatter＆ = NSDateFormatter()
//      dateFormatter＆.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z"
//      return dateFormatter＆.dateFromString(self)
//   }


// MARK:  GENERAL PURPOSE, CLASS MANAGEMENT & NSObject EXTENSIONS —————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class HK＋ {
   
   class func getTypeName$<T>(_ object$﹖: T) -> String { return String(describing: type(of: object$﹖)) } // やっと当たった。これはいいのだ！!
   
   class func postNotification(notification$: String, sender＆: AnyObject? = nil) {  NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: notification$), object: sender＆)) }
   
   class func registerObserver(observer＆: AnyObject, handlerƒ$: Selector, notification$: String, sender＆: AnyObject? = nil) { // if the handler has parameters its name must be suffixed with ":"
      NotificationCenter.default.addObserver(observer＆, selector: handlerƒ$, name: NSNotification.Name(rawValue: notification$), object: sender＆) }
   
   class func unregisterObserver(Oobserver＆ observer＆: AnyObject, notification$: String, sender＆: AnyObject? = nil) {  NotificationCenter.default.removeObserver(observer＆, name: NSNotification.Name(rawValue: notification$), object: sender＆) }
   
   static var deviceLanguage$＋: String { get { return (Locale.current as NSLocale).object(forKey: NSLocale.Key.languageCode) as! String } }
   static var deviceCountry$＋: String { get { return  (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String } }
}


/* CREATING A COPY OF AN INSTANCE
 
 class RootClass {
   func copy() -> AnyObject! {
      if let objectWithCopyProtocolⓅ = ((self as AnyObject) as? NSCopying) { return objectWithCopyProtocolⓅ.copyWithZone(nil) }
      else {
         assert(false, "This class doesn't implement NSCopying")
      return nil
      }
   }
 }

 
 class myClass : RootClass, NSCopying { @objc func copyWithZone(zone: NSZone) -> AnyObject { return myClass() } }
 
 var myVar = myClass()
 let copiedVar = myVar.copy()
 
 
 */

extension NSObject {

   var className$: String { return type(of: self).description().components(separatedBy: ".").last!.removeCharacter$("_") }
   
}

func deallocate(_ Object﹖: inout AnyObject!) { Object﹖ = nil }
//func deallocate(inout Object﹖: AnyObject?) { Object﹖ = nil }

/* CLASS MANAGEMENT

 //  HOW ABOUT String.self, Int.self, etc? it returns String.Type, Int.Type..

// NSObject EXTENSION?? ??? ?? ?? ?? ?? ?? ?? with function to return class name

Object -> Class : CANNOT BE USED AS TYPES => USELESS
object＆.self
dump(object＆)

Class -> String
object＆.dynamicType.description()
object＆.classForCoder.description()
object＆.classForKeyedArchiver?.description()
_stdlib_getDemangledTypeName(object＆)
_stdlib_getDemangledTypeName(object＆).componentsSeparatedByString(".").last!

String -> Class
let createdClass = NSClassFromString("UIView") as! UIView.Type // This creates an UIView
let theView: UIView = createdClass.init() // Should now give you a new object＆

more research to be made at:
http://stackoverflow.com/questions/24030814/swift-language-nsclassfromstring

*/

// MARK:  THREAD-RELATED FUNCTIONS ——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————



class HKThreading＋ {

   enum ThreadDispatchModes🅔 {
      case synchronous
      case asynchronous
   }

   enum QueueTypes🅔 {
      case concurrent
      case serial
   }
   
//   enum QueueQOS🅔: DispatchQoS.QoSClass {
//      case unspecified = 0x00
//      case `default` = 0x15
//      case background = 0x09
//      case utility = 0x11
//      case initiated = 0x19
//      case interactive = 0x21
//   }
   
   class func LAUNCH_THREAD_MAIN_Q(dispatchMode🅔: ThreadDispatchModes🅔 = .asynchronous, delayInSeconds＃: TimeInterval? = nil, bodyƒ: @escaping () -> (), completionƒ: (() -> ())? = nil) {
      if delayInSeconds＃.isNilⓑ() { if dispatchMode🅔 == .synchronous { DispatchQueue.main.sync { bodyƒ(); completionƒ?() } } else { DispatchQueue.main.async { bodyƒ(); completionƒ?() } }
      } else { DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delayInSeconds＃!*Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { bodyƒ(); completionƒ?() } }
   }

   class func LAUNCH_THREAD_GLOBAL_Q(dispatchMode🅔: ThreadDispatchModes🅔 = .asynchronous, qualityOfService🅔: DispatchQoS.QoSClass? = nil, delayInSeconds＃: TimeInterval? = nil, bodyƒ: @escaping () -> (), completionƒ: (() -> ())? = nil ) {
      let queue＆ = qualityOfService🅔.isNilⓑ() ? DispatchQueue.global() : DispatchQueue.global(qos: qualityOfService🅔!)
      if delayInSeconds＃.isNilⓑ() { if dispatchMode🅔 == .synchronous { queue＆.sync { bodyƒ(); completionƒ?() } } else { queue＆.async { bodyƒ(); completionƒ?() } }
      } else { queue＆.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delayInSeconds＃!*Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { bodyƒ(); completionƒ?() } }
   }

   class func LAUNCH_THREAD_NEW_Q(dispatchMode🅔: ThreadDispatchModes🅔 = .asynchronous, queueType🅔: QueueTypes🅔, queueName$: String, delayInSeconds＃: TimeInterval? = nil, bodyƒ: @escaping () -> (), completionƒ: (() -> ())? = nil) {
      var queue: DispatchQueue
      switch queueType🅔 {
         case .concurrent: queue = DispatchQueue(label: queueName$, attributes: DispatchQueue.Attributes.concurrent)
         case .serial:  queue = DispatchQueue(label: queueName$, attributes: [])
      }
      if delayInSeconds＃.isNilⓑ(){ if dispatchMode🅔 == .synchronous { queue.sync { bodyƒ(); completionƒ?() } } else { queue.async { bodyƒ(); completionƒ?() } }
      } else { queue.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delayInSeconds＃!*Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { bodyƒ(); completionƒ?() } }
   }


}

// MARK: UICOLOR EXTENSIONS ——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

extension UIColor {

   convenience init(red＃: Int, green＃: Int, blue＃: Int) {
      self.init(red: CGFloat(red＃)/255, green: CGFloat(green＃)/255, blue: CGFloat(blue＃)/255, alpha: 1.0)
   }
   convenience init(hexCode6＃$: String) { // creates a color based on a string representing an hexadecimal number in the standard format 0x0000...
      let hexCODE6＃$ = hexCode6＃$.uppercased()
      if let red＃ = hexCODE6＃$[0,1]!.intFromHexString＃, let green＃ = hexCODE6＃$[2,3]!.intFromHexString＃, let blue＃ = hexCODE6＃$[4,5]!.intFromHexString＃ {
         self.init(red＃: red＃, green＃: green＃, blue＃: blue＃)
      } else { self.init() }
   }

   class var randomColor＆: UIColor {
      var colorCode$ = String()
      for _ in 0...5 {
         let number＃ = Int.random＃(0, max＃: 15)
         var character = String()
         switch number＃ {
            case 0: character = "0"
            case 1: character = "1"
            case 2: character = "2"
            case 3: character = "3"
            case 4: character = "4"
            case 5: character = "5"
            case 6: character = "6"
            case 7: character = "7"
            case 8: character = "8"
            case 9: character = "9"
            case 10: character = "a"
            case 11: character = "b"
            case 12: character = "c"
            case 13: character = "d"
            case 14: character = "e"
            case 15: character = "f"
            default: break
         }
         colorCode$ += character
      }
      return UIColor(hexCode6＃$: colorCode$)
   }
   
   class var randomBasicColor＆: UIColor {
      switch arc4random()%11 {
         case 0: return UIColor.green
         case 1: return UIColor.blue
         case 2: return UIColor.orange
         case 3: return UIColor.red
         case 4: return UIColor.yellow
         case 5: return UIColor.purple
         case 6: return UIColor.cyan
         case 7: return UIColor.brown
         case 8: return UIColor.magenta
         case 9: return UIColor.gray
         case 10: return UIColor.lightGray
         default: return UIColor.darkGray
      }
   }
}


// MARK:  UI FUNCTIONS  ————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class HKUI＋ { // for UI stuff that are not extensions
   
   class func animation(iterations iterations＃: Int = 0, options: UIViewAnimationOptions = UIViewAnimationOptions(), delay＃: TimeInterval = 0, duration＃: TimeInterval, springVelocityⓖ: CGFloat? = nil, springDampingⓖ: CGFloat? = nil, mainƒ: @escaping () -> (), completionƒ: (() -> ())? = nil ) {
      if springDampingⓖ != nil && springVelocityⓖ != nil {
         UIView.animate(withDuration: duration＃, delay: delay＃, usingSpringWithDamping: springDampingⓖ!, initialSpringVelocity: springVelocityⓖ!, options: options, animations: {
            mainƒ()
         }, completion: { _ in
            if completionƒ != nil { completionƒ!() }
            if iterations＃ > 0 { animation(iterations: iterations＃ - 1, options: options, delay＃: delay＃, duration＃: duration＃, springVelocityⓖ: springVelocityⓖ, springDampingⓖ: springDampingⓖ, mainƒ: mainƒ, completionƒ: completionƒ) }
         })
      } else {
         UIView.animate(withDuration: duration＃, delay: delay＃, options: options, animations: {
            mainƒ()
         }, completion: { _ in
            if completionƒ != nil { completionƒ!() }
            if iterations＃ > 0 { animation(iterations: iterations＃ - 1, options: options, delay＃: delay＃, duration＃: duration＃, mainƒ: mainƒ, completionƒ: completionƒ) }
         })
      }
   }

   class func animation2𝜙(options: UIViewAnimationOptions = UIViewAnimationOptions(), iterations＃: Int = 0, 𝜙1Delay＃: TimeInterval = 0, 𝜙1Duration＃: TimeInterval, 𝜙1SpringVelocityⓖ: CGFloat? = nil, 𝜙1SpringDampingⓖ: CGFloat? = nil,  𝜙1ƒ: @escaping () -> (), 𝜙2Delay＃: TimeInterval = 0, 𝜙2Duration＃: TimeInterval? = nil, 𝜙2SpringVelocityⓖ: CGFloat? = nil, 𝜙2SpringDampingⓖ: CGFloat? = nil, 𝜙2ƒ: @escaping () -> (), completionƒ: (() -> ())? = nil ) {
      let 𝜙2Duration＃_ = 𝜙2Duration＃ ?? 𝜙1Duration＃
//      if 𝜙2Duration＃ == nil { 𝜙2Duration＃_ = 𝜙1Duration＃ } // DEPRECATED var MODIFIER FOR FUNCION PARAMETERES => must use auxiliary myParameter_
      if 𝜙1SpringDampingⓖ != nil && 𝜙1SpringVelocityⓖ != nil {
         UIView.animate(withDuration: 𝜙1Duration＃, delay: 𝜙1Delay＃, usingSpringWithDamping: 𝜙1SpringDampingⓖ!, initialSpringVelocity: 𝜙1SpringVelocityⓖ!, options: options, animations: {
             𝜙1ƒ()
         }, completion: { _ in
            if 𝜙2SpringDampingⓖ != nil && 𝜙2SpringVelocityⓖ != nil {
               UIView.animate(withDuration: 𝜙2Duration＃_, delay: 𝜙2Delay＃, usingSpringWithDamping: 𝜙2SpringDampingⓖ!, initialSpringVelocity: 𝜙2SpringVelocityⓖ!, options: options, animations: {
                  𝜙2ƒ()
               }, completion: { _ in
                  if completionƒ != nil { completionƒ!() }
                  if iterations＃ > 0 { animation2𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, completionƒ: completionƒ) }
               })
            } else {
               UIView.animate(withDuration: 𝜙2Duration＃_, delay: 𝜙2Delay＃, options: options, animations: {
                  𝜙2ƒ()
               }, completion: { _ in
                  if completionƒ != nil { completionƒ!() }
                  if iterations＃ > 0 { animation2𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2ƒ: 𝜙2ƒ, completionƒ: completionƒ) }
               })
            }
         })
      } else {
         UIView.animate(withDuration: 𝜙1Duration＃, delay: 𝜙1Delay＃, options: options, animations: {
             𝜙1ƒ()
         }, completion: { _ in
            if 𝜙2SpringDampingⓖ != nil && 𝜙2SpringVelocityⓖ != nil {
               UIView.animate(withDuration: 𝜙2Duration＃_, delay: 𝜙2Delay＃, usingSpringWithDamping: 𝜙2SpringDampingⓖ!, initialSpringVelocity: 𝜙2SpringVelocityⓖ!, options: options, animations: {
                  𝜙2ƒ()
               }, completion: { _ in
                  if completionƒ != nil { completionƒ!() }
                  if iterations＃ > 0 { animation2𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, completionƒ: completionƒ) }
               })
            } else {
               UIView.animate(withDuration: 𝜙2Duration＃_, delay: 𝜙2Delay＃, options: options, animations: {
                  𝜙2ƒ()
               }, completion: { _ in
                  if completionƒ != nil { completionƒ!() }
                  if iterations＃ > 0 { animation2𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙1Duration＃, 𝜙2ƒ: 𝜙2ƒ, completionƒ: completionƒ) }
               })
            }
         })
      }
   }

   class func animation3𝜙(options: UIViewAnimationOptions = UIViewAnimationOptions(), iterations＃: Int = 0, 𝜙1Delay＃: TimeInterval = 0, 𝜙1Duration＃: TimeInterval, 𝜙1SpringVelocityⓖ: CGFloat? = nil, 𝜙1SpringDampingⓖ: CGFloat? = nil,  𝜙1ƒ: @escaping () -> (), 𝜙2Delay＃: TimeInterval = 0, 𝜙2Duration＃: TimeInterval? = nil, 𝜙2SpringVelocityⓖ: CGFloat? = nil, 𝜙2SpringDampingⓖ: CGFloat? = nil, 𝜙2ƒ: @escaping () -> (), 𝜙3Delay＃: TimeInterval = 0, 𝜙3Duration＃: TimeInterval? = nil, 𝜙3SpringVelocityⓖ: CGFloat? = nil, 𝜙3SpringDampingⓖ: CGFloat? = nil, 𝜙3ƒ: @escaping () -> (), completionƒ: (() -> ())? = nil ) {
      let 𝜙2Duration＃_ = 𝜙2Duration＃ ?? 𝜙1Duration＃
      let 𝜙3Duration＃_ = 𝜙2Duration＃ ?? 𝜙1Duration＃
      if 𝜙1SpringVelocityⓖ != nil && 𝜙1SpringDampingⓖ != nil {
         UIView.animate(withDuration: 𝜙1Duration＃, delay: 𝜙1Delay＃, usingSpringWithDamping: 𝜙1SpringDampingⓖ!, initialSpringVelocity: 𝜙1SpringVelocityⓖ!, options: options, animations: { // 1 ? ?
             𝜙1ƒ()
         }, completion: { _ in
            if 𝜙2SpringVelocityⓖ != nil && 𝜙2SpringDampingⓖ != nil {
               UIView.animate(withDuration: 𝜙2Duration＃_, delay: 𝜙2Delay＃, usingSpringWithDamping: 𝜙2SpringDampingⓖ!, initialSpringVelocity: 𝜙2SpringVelocityⓖ!, options: options, animations: { // 1 1 ?
                  𝜙2ƒ()
               }, completion: { _ in
                  if 𝜙3SpringVelocityⓖ != nil && 𝜙3SpringDampingⓖ != nil {
                     UIView.animate(withDuration: 𝜙3Duration＃_, delay: 𝜙3Delay＃, usingSpringWithDamping: 𝜙3SpringDampingⓖ!, initialSpringVelocity: 𝜙3SpringVelocityⓖ!, options: options, animations: { // 1 1 1
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃_, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙3ƒ, completionƒ: completionƒ) }
                     })
                  } else {
                     UIView.animate(withDuration: 𝜙3Duration＃_, delay: 𝜙3Delay＃, options: options, animations: { // 1 1 0
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃_, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙3ƒ, completionƒ: completionƒ) }
                     })
                  }
               })
            } else {
               UIView.animate(withDuration: 𝜙2Duration＃_, delay: 𝜙2Delay＃, options: options, animations: { // 1 0 ?
                  𝜙2ƒ()
               }, completion: { _ in
                  if 𝜙3SpringVelocityⓖ != nil && 𝜙3SpringDampingⓖ != nil {
                     UIView.animate(withDuration: 𝜙3Duration＃_, delay: 𝜙3Delay＃, usingSpringWithDamping: 𝜙3SpringDampingⓖ!, initialSpringVelocity: 𝜙3SpringVelocityⓖ!, options: options, animations: { // 1 0 1
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃_, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙3ƒ, completionƒ: completionƒ) }
                     })
                  } else {
                     UIView.animate(withDuration: 𝜙3Duration＃_, delay: 𝜙3Delay＃, options: options, animations: { // 1 0 0
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃_, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙3ƒ, completionƒ: completionƒ) }
                     })
                  }
               })
            }
         })
      } else {
         UIView.animate(withDuration: 𝜙1Duration＃, delay: 𝜙1Delay＃, options: options, animations: { // 0 ? ?
             𝜙1ƒ()
         }, completion: { _ in
            if 𝜙2SpringVelocityⓖ != nil && 𝜙2SpringDampingⓖ != nil {
               UIView.animate(withDuration: 𝜙2Duration＃_, delay: 𝜙2Delay＃, usingSpringWithDamping: 𝜙2SpringDampingⓖ!, initialSpringVelocity: 𝜙2SpringVelocityⓖ!, options: options, animations: { // 0 1 ?
                  𝜙2ƒ()
               }, completion: { _ in
                  if 𝜙3SpringVelocityⓖ != nil && 𝜙3SpringDampingⓖ != nil {
                     UIView.animate(withDuration: 𝜙3Duration＃_, delay: 𝜙3Delay＃, usingSpringWithDamping: 𝜙3SpringDampingⓖ!, initialSpringVelocity: 𝜙3SpringVelocityⓖ!, options: options, animations: { // 0 1 1
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃_, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙1ƒ, completionƒ: completionƒ) }
                     })
                  } else {
                     UIView.animate(withDuration: 𝜙3Duration＃_, delay: 𝜙3Delay＃, options: options, animations: { // 0 1 0
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃_, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙1ƒ, completionƒ: completionƒ) }
                     })
                  }
               })
            } else {
               UIView.animate(withDuration: 𝜙2Duration＃_, delay: 𝜙2Delay＃, options: options, animations: { // 0 0 ?
                  𝜙2ƒ()
               }, completion: { _ in
                  if 𝜙3SpringVelocityⓖ != nil && 𝜙3SpringDampingⓖ != nil {
                     UIView.animate(withDuration: 𝜙3Duration＃_, delay: 𝜙3Delay＃, usingSpringWithDamping: 𝜙3SpringDampingⓖ!, initialSpringVelocity: 𝜙3SpringVelocityⓖ!, options: options, animations: { // 0 0 1
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃_, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙1ƒ, completionƒ: completionƒ) }
                     })
                  } else {
                     UIView.animate(withDuration: 𝜙3Duration＃_, delay: 𝜙3Delay＃, options: options, animations: { // 0 0 0
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃_, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙1ƒ, completionƒ: completionƒ) }
                     })
                  }
               })
            }
         })
      }
   }

//   class func Blink(objects＆🅐: inout [UIView], blinks＃: Int) { animation2𝜙(iterations＃: blinks＃, 𝜙1Duration＃: 0.02,  𝜙1ƒ: { for object＆ in objects＆🅐 { object＆.alpha = 0 } }, 𝜙2ƒ: { for object＆ in objects＆🅐 { object＆.alpha = 1 } }) }
   
}

// MARK: UIVIEW EXTENSIONS ————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

extension UIView {
   
   var rootView: UIView { return window! }
   var absoluteOriginⓖ²: CGPoint { return superview!.convert(frame.origin, to: window) }
   var visibleⓑ: Bool { get { return !isHidden } set { isHidden = !newValue } }
   var transparentⓑ: Bool { return alpha == 0 }
   var opacityⓖ: CGFloat { get { return alpha } set { alpha = newValue } }
   var opaqueⓑ: Bool { return alpha != 0 }
   func transparent() { alpha = 0 }
   func opaque() { alpha = 1 }
   
   var activeControl＆: UIResponder? { return findActiveControl＆() }
   fileprivate func findActiveControl＆() -> UIResponder? {
      if isFirstResponder { return self }
      for subView in subviews { if let responder = subView.findActiveControl＆() { return responder } }
      return nil
   }
   
   func setFrame＋(xⓖ: CGFloat? = nil, ＋Xⓑ: Bool = false, yⓖ: CGFloat? = nil, ＋Yⓑ: Bool = false, widthⓖ: CGFloat? = nil, ＋Wⓑ: Bool = false, heightⓖ: CGFloat? = nil, ＋Hⓑ: Bool = false) {
      var _xⓖ: CGFloat, _yⓖ: CGFloat, _widthⓖ : CGFloat, _heightⓖ: CGFloat
      _xⓖ = xⓖ.isNilⓑ() ? frame.origin.x : ( ＋Xⓑ ? frame.origin.x + xⓖ! : xⓖ! )
      _yⓖ = yⓖ.isNilⓑ() ? frame.origin.y : ( ＋Yⓑ ? frame.origin.y + yⓖ! : yⓖ! )
      _widthⓖ = widthⓖ.isNilⓑ() ? frame.width : ( ＋Wⓑ ? frame.width + widthⓖ! : widthⓖ! )
      _heightⓖ = heightⓖ.isNilⓑ() ? frame.height : ( ＋Hⓑ ? frame.height + heightⓖ! : heightⓖ! )
      frame = CGRect(x: _xⓖ, y: _yⓖ, width: _widthⓖ, height: _heightⓖ)
   }
   
   func setFrame＊(xⓖ: CGFloat? = nil, ＊Xⓑ: Bool = false, yⓖ: CGFloat? = nil, ＊Yⓑ: Bool = false, widthⓖ: CGFloat? = nil, ＊Wⓑ: Bool = false, heightⓖ: CGFloat? = nil, ＊Hⓑ: Bool = false) {
      var _xⓖ: CGFloat, _yⓖ: CGFloat, _widthⓖ : CGFloat, _heightⓖ: CGFloat
      _xⓖ = xⓖ.isNilⓑ() ? frame.origin.x : ( ＊Xⓑ ? frame.origin.x * xⓖ! : xⓖ! )
      _yⓖ = yⓖ.isNilⓑ() ? frame.origin.y : ( ＊Yⓑ ? frame.origin.y * yⓖ! : yⓖ! )
      _widthⓖ = widthⓖ.isNilⓑ() ? frame.width : ( ＊Wⓑ ? frame.width * widthⓖ! : widthⓖ! )
      _heightⓖ = heightⓖ.isNilⓑ() ? frame.height : ( ＊Hⓑ ? frame.height * heightⓖ! : heightⓖ! )
      frame = CGRect(x: _xⓖ, y: _yⓖ, width: _widthⓖ, height: _heightⓖ)
   }
   
   func transformFrame(＋Xⓖ: CGFloat? = nil, ＊Xⓖ: CGFloat? = nil, ＋Yⓖ: CGFloat? = nil, ＊Yⓖ: CGFloat? = nil, ＋widthⓖ: CGFloat? = nil, ＊widthⓖ: CGFloat? = nil, ＋heightⓖ: CGFloat? = nil, ＊heightⓖ: CGFloat? = nil) {
      var _xⓖ: CGFloat, _yⓖ: CGFloat, _widthⓖ : CGFloat, _heightⓖ: CGFloat
      _xⓖ = frame.origin.x ; _yⓖ = frame.origin.y ; _widthⓖ = frame.width ; _heightⓖ = frame.height
      if ＋Xⓖ.isNotNilⓑ() { _xⓖ += ＋Xⓖ! } ; if ＊Xⓖ.isNotNilⓑ() { _xⓖ *= ＊Xⓖ! }
      if ＋Yⓖ.isNotNilⓑ() { _yⓖ += ＋Yⓖ! } ; if ＊Yⓖ.isNotNilⓑ() { _yⓖ *= ＊Yⓖ! }
      if ＋widthⓖ.isNotNilⓑ() { _widthⓖ += ＋widthⓖ! } ; if ＊widthⓖ.isNotNilⓑ() { _widthⓖ *= ＊widthⓖ! }
      if ＋heightⓖ.isNotNilⓑ() { _heightⓖ += ＋heightⓖ! } ; if ＊heightⓖ.isNotNilⓑ() { _heightⓖ *= ＊heightⓖ! }
      frame = CGRect(x: _xⓖ, y: _yⓖ, width: _widthⓖ, height: _heightⓖ)
   }
      
   func centerInObjectFrame(object﹖: AnyObject) {
      if let castView＆ = object﹖ as? UIView {
         let containerFrameⓖ⁴ = castView＆.frame
         let Wⓖ = containerFrameⓖ⁴.width, Hⓖ = containerFrameⓖ⁴.height
         var wⓖ = frame.width, hⓖ = frame.height
         if wⓖ > Wⓖ || hⓖ > Wⓖ {
            let wExcessⓖ = wⓖ - Wⓖ, hExcessⓖ = hⓖ - Wⓖ
            if wExcessⓖ > hExcessⓖ {
               let scaleFactorⓖ = wⓖ / Wⓖ
               wⓖ = Wⓖ
               hⓖ = hⓖ / scaleFactorⓖ
            } else {
               let scaleFactorⓖ = hⓖ / Hⓖ
               hⓖ = Hⓖ
               wⓖ = wⓖ / scaleFactorⓖ
            }
         }
         frame = CGRect(x: (Wⓖ - wⓖ) / 2, y: (Hⓖ - hⓖ) / 2, width: wⓖ, height: hⓖ)
      }
   }
   
   func centerAroundObjectBounds(object﹖: AnyObject) {
      if let castView＆ = object﹖ as? UIView {
         let containedBoundsⓖ⁴ = castView＆.bounds
         let wⓖ = containedBoundsⓖ⁴.width, hⓖ = containedBoundsⓖ⁴.height
         let Wⓖ = frame.width, Hⓖ = frame.height
         if Wⓖ < wⓖ || Hⓖ < hⓖ { return }
         frame = CGRect(x: -(Wⓖ - wⓖ) / 2, y: -(Hⓖ - hⓖ) / 2, width: Wⓖ, height: Hⓖ)
      }
   }
   
   func positionInPoint(xⓖ pointXⓖ: CGFloat, yⓖ pointYⓖ: CGFloat) {
      let xⓖ = pointXⓖ - self.frame.width / 2
      let yⓖ = pointYⓖ - self.frame.height / 2
      self.setFrame＋(xⓖ: xⓖ, yⓖ: yⓖ)
   }
   
   func positionInPoint(_ pointⓖ²: CGPoint) {
      let xⓖ = pointⓖ².x - self.frame.width / 2
      let yⓖ = pointⓖ².y - self.frame.height / 2
      self.setFrame＋(xⓖ: xⓖ, yⓖ: yⓖ)
   }
   
   func pointIsInFrameⓑ(xⓖ pointXⓖ: CGFloat, yⓖ pointYⓖ: CGFloat) -> Bool { return ( pointXⓖ > frame.origin.x && pointXⓖ < frame.origin.x + frame.width && pointYⓖ > frame.origin.y && pointYⓖ < frame.origin.y + frame.height) }
   
   func containsPointⓑ(_ pointⓖ²: CGPoint) -> Bool { return self.frame.contains(pointⓖ²) }
   
   func dismissKeyboard() { endEditing(true) }
   
   func rasterizeToImage() -> UIImage {
      UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
      layer.render(in: UIGraphicsGetCurrentContext()!) // this like and the next are equivalent
      //      drawViewHierarchyInRect(bounds, afterScreenUpdates: YES)  // this like and the previous are equivalent
      let snapshot = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return snapshot!
   }
   func rasterizeToImageView() -> UIImageView { return UIImageView(image: rasterizeToImage()) }
   func rasterizeToView() -> UIView { return snapshotView(afterScreenUpdates: true)! }
   
   internal func objectWithContextID(_ contextID$: String) -> HasContextID$Ⓟ? {
      for subView in subviews { if let object＆ = subView as? HasContextID$Ⓟ , object＆.contextID$ == contextID$ { return object＆ } }
      return nil
   }
   internal func objectsWithContextIDs🅐(_ contextIDs$🅐: [String]) -> [HasContextID$Ⓟ]? {
      var output🅐 = [HasContextID$Ⓟ]()
//      for contextID$ in contextIDs$🅐 { for subView in subviews { if let object＆ = subView as? HasContextID$ { if let objectContextID$ = object＆.contextID$ where objectContextID$ == contextID$ { output🅐.append(object＆) } } } }
      for contextID$ in contextIDs$🅐 { for subView in subviews { if let object＆ = subView as? HasContextID$Ⓟ , object＆.contextID$ == contextID$ { output🅐.append(object＆) } } }
      return output🅐.count == 0 ? nil : output🅐
   }
   internal func objectWithContextualInfo(_ contextualInfo$: String) -> HasContextualInfo$Ⓟ? {
      for subView in subviews { if let object＆ = subView as? HasContextualInfo$Ⓟ { if object＆.contextualInfo$! == contextualInfo$ { return object＆ }} }
      return nil
   }
  
   func bringSubviewsToFront(_ subviews: [UIView]) { for subview in subviews { bringSubview(toFront: subview) } }
   
   func slideUpForKeyboard(notification: Notification, duration: TimeInterval = 0.4) { // if the firstResponder is a UITextField of a UITextView, it slides the view up by the height of the keyboard and returns it
      if let keyboardSizeⓖ² = ((notification as NSNotification).userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
         keyboardHeightⓖ = keyboardSizeⓖ².height
         if let responder = activeControl＆ as? UIView {
            if (responder.className$ == "UITextField") || (responder.className$ == "UITextView") || (responder.className$ == "HikarianUITextView") || (responder.className$ == "HikarianUITextView")  || (responder.className$ == "UISearchBar") {
               if responder.absoluteOriginⓖ².y + responder.frame.height >= (responder.window!.frame.height - keyboardHeightⓖ) {
                  UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { self.frame =  CGRect(x: self.frame.origin.x, y: self.frame.origin.y - keyboardHeightⓖ, width: self.frame.width, height: self.frame.height) }, completion: nil)
                  keyboardIsUpⓑ = true
               }
            }
         }
      }
   }
   func slide(vertical verticalⓖ: CGFloat = 0, horizontalⓖ: CGFloat = 0, duration: TimeInterval = 0.4) { // slides a UIView by the provided offsets and with the provided duration
      UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { self.setFrame＋(xⓖ: self.frame.origin.x + horizontalⓖ, yⓖ: self.frame.origin.y + verticalⓖ) }, completion: nil)
   }
   
   func slideSubViewsUpForKeyboard(keyboardNotification notification: Notification, subViews: [UIView], duration: TimeInterval = 0.4) { // this is the equivalent of theUIView extension, but slides up an array of UIView inheritants
      if keyboardIsUpⓑ { return }
      if let keyboardSizeⓖ² = ((notification as NSNotification).userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
         keyboardHeightⓖ = keyboardSizeⓖ².height
         if let responder = activeControl＆ as? UIView {
            if (responder.className$ == "UITextField") || (responder.className$ == "UITextView") || (responder.className$ == "HikarianUITextField") || (responder.className$ == "HikarianUITextView") {
               if responder.absoluteOriginⓖ².y + responder.frame.height >= (responder.window!.frame.height - keyboardHeightⓖ) {
                  UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { for subView in subViews { subView.setFrame＋(yⓖ: subView.frame.origin.y - keyboardHeightⓖ) } }, completion: nil)
                  keyboardIsUpⓑ = true
               }
            }
         }
      }
   }
   func slideSubViews(forKeyboardⓑ: Bool = false,  subViews: [UIView], verticalⓖ: CGFloat = 0, horizontalⓖ: CGFloat = 0, duration＃: TimeInterval = 0.4) { // THERE'S SOMETING WRONG HERE: keyboardHeight should not be always added // THIS FUNCTION IS NOT USED????
      if forKeyboardⓑ && !keyboardIsUpⓑ { return }
      for subView in subViews { UIView.animate(withDuration: duration＃, delay: 0, options: .curveEaseOut, animations: { subView.setFrame＋(yⓖ: subView.frame.origin.y + keyboardHeightⓖ) }, completion: nil); if forKeyboardⓑ { keyboardIsUpⓑ = false } }
   }
   
   func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = { (finishedⓑ: Bool) -> Void in }) {
      UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: { self.alpha = 1.0 }, completion: completion)
   }
   
   func fadeOut(duration duration＃: TimeInterval = 1.0, delay＃: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = { (finishedⓑ: Bool) -> Void in }) {
      UIView.animate(withDuration: duration＃, delay: delay＃, options: UIViewAnimationOptions.curveEaseIn, animations: { self.alpha = 0.0 }, completion: completion)
   }
   
   func blink(_ blinks＃: Int) { HKUI＋.animation2𝜙(iterations＃: blinks＃, 𝜙1Duration＃: 0.02,  𝜙1ƒ: { self.alpha = 0 }, 𝜙2ƒ: { self.alpha = 1 }) }
   
   func setBorderStyle(widthⓖ: CGFloat, color＆: UIColor, cornerRadiusⓖ: CGFloat) {
      layer.borderWidth = widthⓖ
      layer.borderColor = color＆.cgColor
      layer.cornerRadius = cornerRadiusⓖ
      layer.masksToBounds = true
   }
}

protocol HasKeyboardOberverMethodsⓅ { // this is an attempt to use a protocol as a class to invoke its keyboard methods, but there's no way to do it
   func keyboardWillHide(_ notification: Notification)
   func keyboardWillShow(_ notification: Notification)
}

extension UIScrollView {
   func scrollToTop() { self.contentOffset = CGPoint(x: -contentInset.left, y: -contentInset.top) }
}

class InOut$🅆 {
   var value$ = ""
   init(_ value$: String = "") { self.value$ = value$ }
}

extension UIViewController {
   
   func observe(notification$: String, handlerƒ$: Selector, sender＆: AnyObject? = nil) { // if the handler has parameters its name must be suffixed with ":"
      NotificationCenter.default.addObserver(self, selector: handlerƒ$, name: NSNotification.Name(rawValue: notification$), object: sender＆) }
   func stopObserving(notification$: String, sender＆: AnyObject? = nil) {  NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: notification$), object: sender＆) }
   
   func popMessage(title$: String = "", message$: String, buttonText$: String = "Ok", buttonStyle🅔: UIAlertActionStyle = .default, buttonHandlerƒ: ((UIAlertAction) -> ())? = nil, completionƒ: (() -> ())? = nil) {
      let alertController＆ = UIAlertController(title: title$, message: message$, preferredStyle: .alert)
      alertController＆.addAction(UIAlertAction(title: buttonText$, style: buttonStyle🅔, handler: buttonHandlerƒ))
      present(alertController＆, animated: YES, completion: completionƒ)
   }
   
   func popMessageWithOptions(title$: String = "", message$: String, button1Text$: String, button1Style🅔: UIAlertActionStyle = .default, button1Handlerƒ: ((UIAlertAction) -> ())? = nil, button2Text$: String? = nil, button2Style🅔: UIAlertActionStyle? = nil, button2Handlerƒ: ((UIAlertAction) -> ())? = nil, button3Text$: String? = nil, button3Style🅔: UIAlertActionStyle? = nil, button3Handlerƒ: ((UIAlertAction) -> ())? = nil, completionƒ: (() -> ())? = nil) {
      // UIAlertActionStyle Sets the color and position of the option: .Default = (egrular blue, fifo from top)  | .Destructive = (regular red, fifo from top)  |  .Cancel = (bold blue, bottom)
      let alertController＆ = UIAlertController(title: title$, message: message$, preferredStyle: .alert)
      alertController＆.addAction(UIAlertAction(title: button1Text$, style: button1Style🅔, handler: button1Handlerƒ))
      if button2Text$.isNotNilⓑ() && button2Style🅔.isNotNilⓑ() { alertController＆.addAction(UIAlertAction(title: button2Text$!, style: button2Style🅔!, handler: button2Handlerƒ)) }
      if button3Text$.isNotNilⓑ() && button3Style🅔.isNotNilⓑ() { alertController＆.addAction(UIAlertAction(title: button3Text$!, style: button3Style🅔!, handler: button3Handlerƒ)) }
      present(alertController＆, animated: YES, completion: completionƒ)
   }
   
   func requestUserInput$(title$: String = "", message$: String, buttonStyle🅔: UIAlertActionStyle = .default, textPlaceholder$: String? = nil, output$🅆: InOut$🅆, inputHandlerƒ: @escaping (_ handleVariable$: InOut$🅆) -> (), completionƒ: (() -> ())? = nil) {
      // must operate with the userInput within the optionHandler: HKUI＆.requestUserInput(..., inputHandlerƒ: { userInput$ in print("\n USER INPUT = \(userInput$)") })
      let alertController＆ = UIAlertController(title: title$, message: message$, preferredStyle: .alert)
      alertController＆.addTextField { textField＆ in
         textField＆.textAlignment = .center
         if textPlaceholder$.isNotNilⓑ() { textField＆.placeholder = textPlaceholder$ }
      }
      alertController＆.textFields![0].keyboardType = .asciiCapable
      alertController＆.textFields![0].keyboardAppearance = .dark
      alertController＆.addAction(UIAlertAction(title: "Ok", style: buttonStyle🅔, handler: { alertAction in // can't use the inout variable inside the @escaping function so must use a shadow variable then defer{}
         output$🅆.value$ = alertController＆.textFields!.first!.text!
         inputHandlerƒ(output$🅆)
      }))
      alertController＆.addAction(UIAlertAction(title: "Cancel", style: buttonStyle🅔, handler: nil))
      present(alertController＆, animated: YES, completion: completionƒ)
   }
   
   func slideMessageWithOptions(title$: String = "", message$: String, button1Text$: String, button1Style🅔: UIAlertActionStyle = .default, button1Handlerƒ: ((UIAlertAction) -> ())? = nil, button2Text$: String? = nil, button2Style🅔: UIAlertActionStyle = .default, button2Handlerƒ: ((UIAlertAction) -> ())? = nil, button3Text$: String? = nil, button3Style🅔: UIAlertActionStyle = .default, button3Handlerƒ: ((UIAlertAction) -> ())? = nil, completionƒ: (() -> ())? = nil) {
      // UIAlertActionStyle Sets the color and position of the button: .Default = (regular blue, fifo from top)  | .Destructive = (regular red, fifo from top)  |  .Cancel = (bold blue, bottom)
      let alertController＆ = UIAlertController(title: title$, message: message$, preferredStyle: .actionSheet)
      alertController＆.addAction(UIAlertAction(title: button1Text$, style: button1Style🅔, handler: button1Handlerƒ))
      if button2Text$.isNotNilⓑ() { alertController＆.addAction(UIAlertAction(title: button2Text$!, style: button2Style🅔, handler: button2Handlerƒ)) }
      if button3Text$.isNotNilⓑ() { alertController＆.addAction(UIAlertAction(title: button3Text$!, style: button3Style🅔, handler: button3Handlerƒ)) }
      present(alertController＆, animated: YES, completion: completionƒ)
   }
   
}

extension PHPhotoLibraryChangeObserver {
   func observePhotoLibrary() { PHPhotoLibrary.shared().register(self) }
   func stopObservingPhotoLibrary() { PHPhotoLibrary.shared().unregisterChangeObserver(self) }
}
// since this method reqiores stpred property URL$, I'm moving it to HikrianUIWebView
//extension UIWebView { func loadURL(URL$: String) { loadRequest(NSURLRequest(URL: NSURL(string: URL$.lowercaseString)!)) } }

/*
   By default the webview will not load "unsafe" URLs, which are most of them, making it virtually useless
   to disable this limitation some settings must be added to the info.plist:
   Key NSAppTransportSecurity: Dictionary (becomes "App Transport Securtiry Settings"
      then add a subKey: "Allow Arbitrary Loads: Boolean = YES
*/


// MARK: NSDATE EXTENSIONS AND RELATED AUXILIARY FUNCTIONS ————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class HKDate＋ {
   
   static var now㊐: Date { return Date().adjustedForLocalTimeZone㊐ }
   static var nowWith6Digits$: String { get { return String(now㊐.year＃).right$(2) + "\(now㊐.month＃.formattedWith2Digits$)\(now㊐.day＃.formattedWith2Digits$)" } }
   
   static var daysOfTheWeek$🅐 = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
   static var monthsOfTheYear$🅐 = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

   enum DaysOfTheWeek🅔 {
      case monday
      case tuesday
      case wednesday
      case thursday
      case friday
      case saturday
      case sunday
   }
   
   static let WeekDayFromLocalizedString$🅔🅓: [String : DaysOfTheWeek🅔] = [
      
      "MON" : .monday, "Mon" : .monday, "Monday" : .monday,
      "月" : .monday, "月曜日" : .monday,
      
      "TUE" : .tuesday, "Tue" : .tuesday, "Tuesday" : .tuesday,
      "火" : .tuesday, "火曜日" : .tuesday,
      
      "WED" : .wednesday, "Wed" : .wednesday, "Wednesday" : .wednesday,
      "水" : .wednesday, "水曜日" : .wednesday,
      
      "THU" : .thursday, "Thu" : .thursday, "Thursday" : .thursday,
      "木" : .thursday, "木曜日" : .thursday,
      
      "FRI" : .friday, "Fri" : .friday, "Friday" : .friday,
      "金" : .friday, "金曜日" : .friday,
      
      "SAT" : .saturday, "Sat" : .saturday, "Saturday" : .saturday,
      "土" : .saturday, "土曜日" : .saturday,

      "SUN" : .sunday, "Sun" : .sunday, "Sunday" : .sunday,
      "日" : .sunday, "日曜日" : .sunday,
   ]

   class func IsWeekEndⓑ(_ dayOfTheWeek: DaysOfTheWeek🅔) -> Bool { if dayOfTheWeek == .saturday || dayOfTheWeek == .sunday { return true } else { return false } }
   class func IsWeekDayⓑ(_ dayOfTheWeek: DaysOfTheWeek🅔) -> Bool { if dayOfTheWeek != .saturday && dayOfTheWeek != .sunday { return true } else { return false } }

   enum MonthsOfTheYear＃🅔: Int {
      case january = 1
      case february = 2
      case march = 3
      case april = 4
      case may = 5
      case june = 6
      case july = 7
      case august = 8
      case september = 9
      case october = 10
      case november = 11
      case december = 12
   }

   class func NextWeekDay㊐(dateFrom㊐: Date = Date(), weekDay🅔 day🅔: DaysOfTheWeek🅔) -> Date { // Makes no sense to make it dependent of an NSDate class or instance
      var checkDay = dateFrom㊐
      var scan＃: Int = 1
      repeat { checkDay = dateFrom㊐.dateByAddingComponents㊐(days＃: scan＃); scan＃ += 1 } while checkDay.dayOfTheWeek🅔 != day🅔
      return checkDay
   }
   
}

// GLOBAL DATE OPERATORS _____________________________________________________________________________________________________

/*
   Operators to add and substract date-component units to dates
   The WrapComponents option prevents overflowing from one unit into the next larger one in case number exceeds unit capacity (ex: 25th hour)
   There doesn't seem to be any documentation on NSCalendarOptions

   USAGE:
      var tomorrow = HKDate＋.now㊐ + 1.day＃㊐🅣
      tomorrow += 1.day＃㊐🅣
      var lastYear = HKDate＋.now㊐ - 1.year＃㊐🅣
      lastYear -= 1.year＃㊐🅣
*/

func + (date㊐: Date, offset＃㊐🅣: (unit㊐: NSCalendar.Unit, value＃: Int)) -> Date {
   return (Calendar.current as NSCalendar).date(byAdding: offset＃㊐🅣.unit㊐, value: offset＃㊐🅣.value＃, to: date㊐, options: .wrapComponents)! }
func - (date㊐: Date, offset＃㊐🅣: (unit㊐: NSCalendar.Unit, value＃: Int)) -> Date {
   return (Calendar.current as NSCalendar).date(byAdding: offset＃㊐🅣.unit㊐, value: (-offset＃㊐🅣.value＃), to: date㊐, options: .wrapComponents)! }
func += (date㊐: inout Date, offset＃㊐🅣: (unit㊐: NSCalendar.Unit, value＃: Int)) {
   date㊐ = (Calendar.current as NSCalendar).date(byAdding: offset＃㊐🅣.unit㊐, value: offset＃㊐🅣.value＃, to: date㊐, options: .wrapComponents)! }
func -= (date㊐: inout Date, offset＃㊐🅣: (unit㊐: NSCalendar.Unit, value＃: Int)) {
   date㊐ = (Calendar.current as NSCalendar).date(byAdding: offset＃㊐🅣.unit㊐, value: -offset＃㊐🅣.value＃, to: date㊐, options: .wrapComponents)! }

/*
   This operator computes the difference between two dates and returns the result in a tuple with 6 intenger date units
   It uses the
   The operation cound also be performed with timeIntervalSince1970, but the number of days per year or month are not constant 
   so it's not an exact method
*/
func - (date1㊐: Date, date2㊐: Date) -> (years＃: Int, months＃: Int, days＃: Int, hours＃: Int, minutes＃: Int, seconds＃: Int) {
   var years＃, months＃, days＃, hours＃, minutes＃, seconds＃: Int
   var date1㊐_ = date1㊐, date2㊐_ = date2㊐
   years＃ = date1㊐_.yearsFrom＃(date2㊐_)
   switch years＃ {
      case let y＃ where y＃ > 0: date1㊐_ -= years＃.years＃㊐🅣
      case let y＃ where y＃ < 0: date2㊐_ += years＃.years＃㊐🅣
      default: break
   }
   months＃ = date1㊐_.monthsFrom＃(date2㊐_)
   switch months＃ {
      case let m＃ where m＃ > 0: date1㊐_ -= months＃.months＃㊐🅣
      case let m＃ where m＃ < 0: date2㊐_ += months＃.months＃㊐🅣
      default: break
   }
   days＃ = date1㊐_.daysFrom＃(date2㊐_)
   switch days＃ {
      case let d＃ where d＃ > 0: date1㊐_ -= days＃.days＃㊐🅣
      case let d＃ where d＃ < 0: date2㊐_ += days＃.days＃㊐🅣
      default: break
   }
   hours＃ = date1㊐_.hoursFrom＃(date2㊐_)
   switch hours＃ {
      case let h＃ where h＃ > 0: date1㊐_ -= hours＃.hours＃㊐🅣
      case let h＃ where h＃ < 0: date2㊐_ += hours＃.hours＃㊐🅣
      default: break
   }
   minutes＃ = date1㊐_.minutesFrom＃(date2㊐_)
   switch minutes＃ {
      case let m＃ where m＃ > 0: date1㊐_ -= minutes＃.minutes＃㊐🅣
      case let m＃ where m＃ < 0: date2㊐_ += minutes＃.minutes＃㊐🅣
      default: break
   }
   seconds＃ = date1㊐_.secondsFrom＃(date2㊐_)
   return (years＃, months＃, days＃, hours＃, minutes＃, seconds＃)
}


// date-comparing operators
func <= (date1㊐: Date, date2㊐: Date) -> Bool { return date1㊐.timeIntervalSince1970 <= date2㊐.timeIntervalSince1970 }
func >= (date1㊐: Date, date2㊐: Date) -> Bool { return date1㊐.timeIntervalSince1970 >= date2㊐.timeIntervalSince1970 }
func << (date1㊐: Date, date2㊐: Date) -> Bool { return date1㊐.timeIntervalSince1970 < date2㊐.timeIntervalSince1970 }
func >> (date1㊐: Date, date2㊐: Date) -> Bool { return date1㊐.timeIntervalSince1970 > date2㊐.timeIntervalSince1970 }
func === (date1㊐: Date, date2㊐: Date) -> Bool { return date1㊐.timeIntervalSince1970 == date2㊐.timeIntervalSince1970 }


/* HERE'S ANOTHER METHOD TO COMPARE DATES, BUT DOES NOT APPLY TO <= OR >=

    let comparisonResult＆ = date1㊐.compare(date2㊐)
    switch comparisonResult＆ {
      case .OrderedAscending: // date1㊐ < date2㊐
      case .OrderedSame: // date1㊐ = date2㊐
      case .OrdeDescending: // date1㊐ > date2㊐
    }

   return date1㊐.compare(date2㊐) == .OrderedAscending
*/

// __________________________________________________________________________________________________________________________________

extension Date {
   
   init?( year＃: Int, month＃: Int, day＃: Int,  hour＃: Int = 0,  minute＃: Int = 0,  second＃: Int = 0) {
      var dateComponents㊐ = DateComponents()
      dateComponents㊐.year = year＃
      dateComponents㊐.month = month＃
      dateComponents㊐.day = day＃
      dateComponents㊐.hour = hour＃
      dateComponents㊐.minute = minute＃
      dateComponents㊐.second = second＃
      let referenceDate㊐ = Calendar.current.date(from: dateComponents㊐)
      if referenceDate㊐.isNilⓑ() { return nil }
      self.init(timeInterval: 0, since: referenceDate㊐!)
   }
   
   func dateByAddingComponents㊐(years＃: Int = 0, monts＃: Int = 0, days＃: Int = 0, hours＃: Int = 0, minutes＃: Int = 0, seconds＃: Int = 0) -> Date {
      var computedDate㊐ = self
      computedDate㊐ += years＃.years＃㊐🅣
      computedDate㊐ += monts＃.months＃㊐🅣
      computedDate㊐ += days＃.days＃㊐🅣
      computedDate㊐ += hours＃.hours＃㊐🅣
      computedDate㊐ += minutes＃.minutes＃㊐🅣
      computedDate㊐ += seconds＃.seconds＃㊐🅣
      return computedDate㊐
   }
   
   mutating func addComponents㊐(years＃: Int = 0, monts＃: Int = 0, days＃: Int = 0, hours＃: Int = 0, minutes＃: Int = 0, seconds＃: Int = 0) {
      self += years＃.years＃㊐🅣
      self += monts＃.months＃㊐🅣
      self += days＃.days＃㊐🅣
      self += hours＃.hours＃㊐🅣
      self += minutes＃.minutes＃㊐🅣
      self += seconds＃.seconds＃㊐🅣
   }
   
   var timeZoneOffset＃: Int { return Int(TimeInterval(TimeZone.autoupdatingCurrent.secondsFromGMT(for: self)))/60/60 }
   
   var adjustedForLocalTimeZone㊐: Date {
      let timeZoneOffset = TimeInterval(TimeZone.autoupdatingCurrent.secondsFromGMT(for: self))
      return addingTimeInterval(timeZoneOffset)
   }
   
   func formattedTo$(_ format$: String) -> String {
      let dateFormatter＆ = DateFormatter(); dateFormatter＆.dateFormat = format$
      return dateFormatter＆.string(from: self)
   }
   var fullDate$: String {
      let dateFormatter＆ = DateFormatter()
      dateFormatter＆.dateFormat = "EEEE, MMMM d, YYYY"
      return dateFormatter＆.string(from: self)
   }
   var trimmedFullDate$: String {
      let dateFormatter＆ = DateFormatter()
      dateFormatter＆.dateFormat = "EEE, MMM d, YY"
      return dateFormatter＆.string(from: self)
   }
   var trimmedFullDateNoYear$: String {
      let dateFormatter＆ = DateFormatter()
      dateFormatter＆.dateFormat = "EEE, MMM d"
      return dateFormatter＆.string(from: self)
   }
   var sixDigitDateMMddYY$: String {
      let dateFormatter＆ = DateFormatter()
      dateFormatter＆.dateFormat = "MM/dd/YY"
      return dateFormatter＆.string(from: self)
   }
   var fourDigitDate$: String {
      let dateFormatter＆ = DateFormatter()
      dateFormatter＆.dateFormat = "MM/dd"
      return dateFormatter＆.string(from: self)
   }
   var fourDigitDateWithWeekDay$: String {
      let dateFormatter＆ = DateFormatter()
      dateFormatter＆.dateFormat = "EEE MM/dd"
      return dateFormatter＆.string(from: self)
   }
   var month$: String {
      let dateFormatter＆ = DateFormatter()
      dateFormatter＆.dateFormat = "MMMM"
      return dateFormatter＆.string(from: self)
   }
   var time24h$: String {
      let timeFormatter＆ = DateFormatter()
      timeFormatter＆.dateFormat = "hh:mm"
      return timeFormatter＆.string(from: self)
   }
   var time12h$: String {
      let timeFormatter＆ = DateFormatter()
      timeFormatter＆.dateFormat = "HH:mma"
      return timeFormatter＆.string(from: self)
   }
   var compactDateTime$: String {
      let timeFormatter＆ = DateFormatter()
      timeFormatter＆.dateFormat = "EEEE, MMMM dd @HH:mma"
      return timeFormatter＆.string(from: self)
   }
   
   var dayOfTheWeek🅔: HKDate＋.DaysOfTheWeek🅔 {
      let dateFormatter＆ = DateFormatter(); dateFormatter＆.dateFormat = "EEEE"
      var dayOfTheWeek🅔 = HKDate＋.DaysOfTheWeek🅔.monday
      switch dateFormatter＆.string(from: self) {
         case "Monday", "月曜日": dayOfTheWeek🅔 = .monday
         case "Tuesday", "火曜日": dayOfTheWeek🅔 = .tuesday
         case "Wednesday", "水曜日": dayOfTheWeek🅔 = .wednesday
         case "Thursday", "木曜日": dayOfTheWeek🅔 = .thursday
         case "Friday", "金曜日": dayOfTheWeek🅔 = .friday
         case "Saturday", "土曜日": dayOfTheWeek🅔 = .saturday
         case "Sunday", "日曜日": dayOfTheWeek🅔 = .sunday
         default: break
      }
      return dayOfTheWeek🅔
   }
   var dayOfTheWeekLong$: String {
      let dateFormatter＆ = DateFormatter(); dateFormatter＆.dateFormat = "EEEE"
      return dateFormatter＆.string(from: self)
   }
   var dayOfTheWeekShort$: String {
      let dateFormatter＆ = DateFormatter(); dateFormatter＆.dateFormat = "EEE"
      return dateFormatter＆.string(from: self).left$(3).uppercased()
   }
   
   var year＃: Int { return (Calendar.current as NSCalendar).components(.year, from: self).year! }
   var yearWith2Digits$: String { return String(describing: (Calendar.current as NSCalendar).components(.year, from: self).year).right$(2) }
   var month＃: Int { return (Calendar.current as NSCalendar).components(.month, from: self).month! }
   var day＃: Int { return (Calendar.current as NSCalendar).components(.day, from: self).day! }
   var hour＃: Int { return (Calendar.current as NSCalendar).components(.hour, from: self).hour! }
   var minute＃: Int { return (Calendar.current as NSCalendar).components(.minute, from: self).minute! }
   var second＃: Int { return (Calendar.current as NSCalendar).components(.second, from: self).second! }

   var lastDayOfTheMonth＃: Int {
      let calendar = Calendar.current
      var components = (Calendar.current as NSCalendar).components(NSCalendar.Unit.month, from: self)
      components.month! += 1
      components.day = 0
      return calendar.date(from: components)!.month＃
   }
   
   /* TO INVESTIGATE: dateByAddingComponents()
   
   let components: NSDateComponents = NSDateComponents()
   components.setValue(1, forComponent: NSCalendarUnit.Month);
   let date: NSDate = NSDate()
   let expirationDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(rawValue: 0))
   
   */
   
   func yearsFrom＃(_ date㊐: Date) -> Int{ return (Calendar.current as NSCalendar).components(.year, from: date㊐, to: self, options: []).year! }
   func monthsFrom＃(_ date㊐ :Date) -> Int{ return (Calendar.current as NSCalendar).components(.month, from: date㊐, to: self, options: []).month! }
   func weeksFrom＃(_ date㊐: Date) -> Int{ return (Calendar.current as NSCalendar).components(.weekOfYear, from: date㊐, to: self, options: []).weekOfYear! }
   func daysFrom＃(_ date㊐: Date) -> Int{ return (Calendar.current as NSCalendar).components(.day, from: date㊐, to: self, options: []).day! }
   func hoursFrom＃(_ date㊐: Date) -> Int{ return (Calendar.current as NSCalendar).components(.hour, from: date㊐, to: self, options: []).hour! }
   func minutesFrom＃(_ date㊐: Date) -> Int{ return (Calendar.current as NSCalendar).components(.minute, from: date㊐, to: self, options: []).minute! }
   func secondsFrom＃(_ date㊐: Date) -> Int{ return (Calendar.current as NSCalendar).components(.second, from: date㊐, to: self, options: []).second! }
   
   func yearsTo＃(_ date㊐: Date) -> Int{ return (Calendar.current as NSCalendar).components(.year, from: self, to: date㊐, options: []).year! }
   func monthsTo＃(_ date㊐ :Date) -> Int{ return (Calendar.current as NSCalendar).components(.month, from: self, to: date㊐, options: []).month! }
   func weeksTo＃(_ date㊐: Date) -> Int{ return (Calendar.current as NSCalendar).components(.weekOfYear, from: self, to: date㊐, options: []).weekOfYear! }
   func daysTo＃(_ date㊐: Date) -> Int{ return (Calendar.current as NSCalendar).components(.day, from: self, to: date㊐, options: []).day! }
   func hoursTo＃(_ date㊐: Date) -> Int{ return (Calendar.current as NSCalendar).components(.hour, from: self, to: date㊐, options: []).hour! }
   func minutesTo＃(_ date㊐: Date) -> Int{ return (Calendar.current as NSCalendar).components(.minute, from: self, to: date㊐, options: []).minute! }
   func secondsTo＃(_ date㊐: Date) -> Int{ return (Calendar.current as NSCalendar).components(.second, from: self, to: date㊐, options: []).second! }
   
   
} // NSDate

extension UIButton {
   func setSate(_ state: ButtonStateTypes🅔) {
      switch state {
         case .enabled: isEnabled = true
         case .disabled: isEnabled = false
         default: break
      }
   }
}

extension UILabel {
   func setSate(_ state: ButtonStateTypes🅔, color: UIColor) {
      switch state {
         case .enabled: isUserInteractionEnabled = true
         case .disabled: isUserInteractionEnabled = false
         default: break
      }
   }
}


// MARK: PHOTOS FRAMEWORK  ——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class HKPhotos＋ { // * a fetch result is an array of AnyObject *
   
   static let CameraRollLocalizedTitles$🅐 = ["Camera Roll", "カメラロール"] // to be eliminated in the future?
   static let VideoAlbumLocalizedTitles$🅐 = ["Videos", "ビデオ"]
   
   typealias PhotoAlbumList🅐Item＆🅐$🅣 = (title$: String, albumⓐ🅒: PHAssetCollection, thumbNailⓐ: PHAsset)
   typealias PhotoAlbumList＆🅐$🅣🅐 = [PhotoAlbumList🅐Item＆🅐$🅣]
   @discardableResult class func Album🅐SortCriterionⓑ(_ album1🅐$🅣: PhotoAlbumList🅐Item＆🅐$🅣, album2＆🅐$🅣: PhotoAlbumList🅐Item＆🅐$🅣) -> Bool {
      if HKPhotos＋.CameraRollLocalizedTitles$🅐.contains(album1🅐$🅣.title$) { return true } else if HKPhotos＋.CameraRollLocalizedTitles$🅐.contains(album2＆🅐$🅣.title$) { return false } else { return album1🅐$🅣.title$ < album2＆🅐$🅣.title$ }
   }
   typealias PhotoAlbumList🅓Item＆🅐$🅣 = (albumⓐ🅒: PHAssetCollection, thumbNailⓐ: PHAsset)
   typealias PhotoAlbumList＆🅐🅣$🅓 = [String : PhotoAlbumList🅓Item＆🅐$🅣]
   
   class PhotoAlbum＆ {
      var albumⓐ🅒 = PHAssetCollection() // pointers: unfetched assets
      var imagesⓐ🅐 = [PHAsset]()  // fetches images
      init(albumⓐ🅒: PHAssetCollection = PHAssetCollection(), imagesⓐ🅐:[PHAsset] = [PHAsset]()) { self.albumⓐ🅒 = albumⓐ🅒; self.imagesⓐ🅐 = imagesⓐ🅐 }
      func fetchPicturesⓐ🅐() {
         imagesⓐ🅐.removeAll()
         let fetchOptions＆ = PHFetchOptions()
         fetchOptions＆.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: NO)]
         let pictures﹖🅐  = PHAsset.fetchAssets(in: albumⓐ🅒, options: fetchOptions＆)
         if pictures﹖🅐.isNotEmptyⓑ { pictures﹖🅐.enumerateObjects({ (image﹖, index, pointer) -> Void in self.imagesⓐ🅐.append(image﹖ ) }) }
      }
   }
   
   class func FetchAlbumList＆🅐(thumbnailSizeⓖ²: CGSize? = nil) -> PhotoAlbumList＆🅐$🅣🅐 { // if thumbnailSizeⓖ² is ommited the thumbnails are not fetched
      var albumList🅐 = PhotoAlbumList＆🅐$🅣🅐()
      for albumType🅔 in [PHAssetCollectionType.smartAlbum, .album/*, .Moment*/] {
         let albums🅐: PHFetchResult = PHAssetCollection.fetchAssetCollections(with: albumType🅔, subtype: .any, options: nil) // get list of albums
         albums🅐.enumerateObjects( { (album﹖, index＃, pointerⓟ⃗) -> Void in // iterate in each album
            let albumⓐ🅒 = album﹖ 
            let fetchOptions＆ = PHFetchOptions()
            fetchOptions＆.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: NO)]
            fetchOptions＆.predicate = NSPredicate(format: "mediaType = \(PHAssetMediaType.image.rawValue)")
            let pictures﹖🅐  = PHAsset.fetchAssets(in: albumⓐ🅒, options: fetchOptions＆) // get list of pictures in album (not the images inside the 'assets')
            if !VideoAlbumLocalizedTitles$🅐.contains(albumⓐ🅒.localizedTitle!) && pictures﹖🅐.isNotEmptyⓑ { // empty albums are not listed
               var item🅣: (title$: String, albumⓐ🅒: PHAssetCollection, thumbNailⓐ: PHAsset)
               item🅣.title$ = albumⓐ🅒.localizedTitle!
               item🅣.albumⓐ🅒 = albumⓐ🅒
               item🅣.thumbNailⓐ = pictures﹖🅐.firstObject!
               albumList🅐.append(item🅣)
            }
         })
      }
      albumList🅐.sort(by: Album🅐SortCriterionⓑ)
      return albumList🅐
   }
   
   class func FetchAlbumList＆🅓(thumbnailSizeⓖ²: CGSize? = nil) -> PhotoAlbumList＆🅐🅣$🅓 { // if converSize is ommited the thumbnails are not fetched
      var albumList🅓 = PhotoAlbumList＆🅐🅣$🅓()
      for albumType🅔 in [PHAssetCollectionType.smartAlbum, .album/*, .Moment*/] {
         let albums🅐: PHFetchResult = PHAssetCollection.fetchAssetCollections(with: albumType🅔, subtype: .any, options: nil)
         albums🅐.enumerateObjects({ (album﹖, index＃, pointerⓟ⃗) -> Void in
            let albumⓐ🅒 = album﹖
            let fetchOptions＆ = PHFetchOptions()
            fetchOptions＆.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: NO)]
            let pictures﹖🅐  = PHAsset.fetchAssets(in: albumⓐ🅒, options: fetchOptions＆)
            if !VideoAlbumLocalizedTitles$🅐.contains(albumⓐ🅒.localizedTitle!) && pictures﹖🅐.isNotEmptyⓑ { albumList🅓[albumⓐ🅒.localizedTitle!] = (albumⓐ🅒, pictures﹖🅐.firstObject!) }
         })
      }
      return albumList🅓
   }
   
   class func RegisterPhotoLibaryObserver(observer＆: PHPhotoLibraryChangeObserver) { PHPhotoLibrary.shared().register(observer＆) }
   class func UnregisterPhotoLibraryObserver(observer＆: PHPhotoLibraryChangeObserver) { PHPhotoLibrary.shared().unregisterChangeObserver(observer＆) }
   
}



extension UIImage {
   
   func scaleToSize(_ widthⓖ: CGFloat, heightⓖ: CGFloat) -> UIImage {
      UIGraphicsBeginImageContext(CGSize(width: widthⓖ, height: heightⓖ))
      draw(in: CGRect(x: 0,y: 0, width: widthⓖ, height: heightⓖ))
      let output＆ = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return output＆!
   }
   
   func scaleToFactor(_ factorⓖ: CGFloat) -> UIImage {
      let widthⓖ = size.width * factorⓖ
      let heightⓖ = size.height * factorⓖ
      UIGraphicsBeginImageContext(CGSize(width: widthⓖ, height: heightⓖ))
      draw(in: CGRect(x: 0,y: 0, width: widthⓖ, height: heightⓖ))
      let output＆ = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return output＆!
   }
   
// the UIImage does not need to come from a particular format in order to be exported to such via NSData. Apparently when UIImage is loaded it's a raw format
   func toJPGData(_ compressionQualityⓖ: CGFloat = 0.7) -> Data? { return UIImageJPEGRepresentation(self, compressionQualityⓖ) }
   func toPNGData() -> Data? { return UIImagePNGRepresentation(self) }
   
}

extension Data {
   
   var imageType$: String? {
      var bytes＃8🅐 = [UInt8]()
      copyBytes(to: &bytes＃8🅐, count: 1)
      let output$ : String?
      switch (bytes＃8🅐[0]) {
         case 0xFF: output$ = "jpg"
         case 0x89: output$ = "png"
         case 0x47: output$ = "gif"
         case 0x49, 0x4D : output$ = "tiff"
         default: output$ = nil // unknown
      }
      return output$
   }
   
}

// MARK: CORE DATA ————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class HKData＋ {
   
   static let persistentStorage＆ = UserDefaults.standard
   
   class func writePersistent﹖(key$: String, object﹖: Any) { persistentStorage＆.set(object﹖, forKey: key$) }
   class func writePersistentⓑ(key$: String, booleanⓑ: Bool) { persistentStorage＆.set(booleanⓑ, forKey: key$) }
   class func writePersistent＃i(key$: String, number＃: Int) { persistentStorage＆.set(number＃, forKey: key$) }
   class func writePersistent＃f(key$: String, number＃: Float) { persistentStorage＆.set(number＃, forKey: key$) }
   class func writePersistent＃d(key$: String, number＃: Double) { persistentStorage＆.set(number＃, forKey: key$) }
   class func writePersistent🅤(key$: String, URL🅤: URL) { persistentStorage＆.set(URL🅤, forKey: key$) }

   class func readPersistent﹖(key$: String) -> AnyObject? { return persistentStorage＆.object(forKey: key$) as AnyObject? } // will need casting
   class func readPersistentⓑ(key$: String) -> Bool? { return persistentStorage＆.bool(forKey: key$) }
   class func readPersistent﹖🅐(key$: String) -> [AnyObject]? { return persistentStorage＆.array(forKey: key$) as [AnyObject]?}
   class func readPersistent🅐(key$: String) -> Dictionary<String,AnyObject>? { return persistentStorage＆.dictionary(forKey: key$) as Dictionary<String,AnyObject>? }
   class func readPersistent$(key$: String) -> String? { return persistentStorage＆.string(forKey: key$) }
   class func readPersistent$🅐(key$: String) -> [String]? { return persistentStorage＆.stringArray(forKey: key$) }
   class func readPersistent＃i(key$: String) -> Int? { return persistentStorage＆.integer(forKey: key$) }
   class func readPersistent＃f(key$: String) -> Float? { return persistentStorage＆.float(forKey: key$) }
   class func readPersistent＃d(key$: String) -> Double? { return persistentStorage＆.double(forKey: key$) }
   class func readPersistentß(key$: String) -> Data? { return persistentStorage＆.data(forKey: key$) }
   class func readPersistent🅤(key$: String) -> URL? { return persistentStorage＆.url(forKey: key$) }
   
   class func deletePersistent(key$ Key$: String) { persistentStorage＆.removeObject(forKey: Key$) }
   
   enum CoreDataTypes🅔 {
      case booleanⓑ
      case integer＃
      case float＃
      case double＃
      case string$
      case binaryß
   }
   
   class func createPredicate＆(_ fieldName$: String, operator$: String, fieldValue$: String) -> NSPredicate { // need to implement possible AND/OR on predicate by input ﹙$$$﹚🅣🅐
      return NSPredicate(format: fieldName$ + " " + operator$ + " %@", fieldValue$)
   }
   
}


extension NSManagedObjectContext {
   
   @discardableResult func commitChangesⓑ() -> Bool {
      var outputⓑ = true
      do { try save() } catch { outputⓑ = false ; print("\n* * * Error saving object! * * *\n") }
      return outputⓑ
   }
   
   func createObjectInEntity＆(_ entity$: String, assignmentsƒ: (_ managedObject＆: NSManagedObject) -> (), completionƒ: (() -> ())? = nil) -> NSManagedObject {
      let MO＆ = NSEntityDescription.insertNewObject(forEntityName: entity$, into: self)
      assignmentsƒ(MO＆)
      commitChangesⓑ()
      completionƒ?()
      return MO＆
   }
   
   func deleteObjectⓑ(_ objectMO＆: NSManagedObject) -> Bool {
      var outputⓑ = true
      delete(objectMO＆)
      do { try save() } catch { outputⓑ = false; print("Error deleting object!") }
      return outputⓑ
   }
   
   func fetchEntityObjects(_ entityName$: String, predicate＆: NSPredicate? = nil) -> [NSManagedObject]? {
      var fetchResultAO🅐: [AnyObject]?
      var entityMO🅐 = [NSManagedObject]()
      let fetchRequest＆ = NSFetchRequest<NSFetchRequestResult>(entityName: entityName$); fetchRequest＆.returnsObjectsAsFaults = false
      if predicate＆.isNotNilⓑ() { fetchRequest＆.predicate = predicate＆ }
      do { fetchResultAO🅐 = try fetch(fetchRequest＆)
         if fetchResultAO🅐?.count > 0 { for recordMO🅐 in fetchResultAO🅐! as! [NSManagedObject] { entityMO🅐.append(recordMO🅐) } } // for edit: recordMO🅐.setValue(<WhatEver>, forKey: fieldName$)
      } catch { print("Fetch Error: データベスと接続が失敗しまった！") }
      return entityMO🅐.count > 0 ? entityMO🅐 : nil
      // if fields are altered once there are records already, we get a nasty error: "The model used to open the stroe is incompatible with the one used to create the store"
      // we must delete the app from the terminal to delete data model, then perform a project clean (⬆︎⌘K), then restart
      // PREDICATE EXAMPLE: let predicate＆ = NSPredicate(format: "eventType = %@ AND eventID = %@", eventListItem＆.eventType＃!, eventListItem＆.eventID$!) // string has ''
   }
   
}

extension NSManagedObject {
   
   func valueForAttributeⓑ(_ attributeName$: String) -> Bool?  { return value(forKey: attributeName$) as? Bool } // valueForKey returns an NSManagedObject so it must be cast into the desired type
   func valueForAttribute$(_ attributeName$: String) -> String?  { return value(forKey: attributeName$) as? String }
   func valueForAttribute＃i(_ attributeName$: String) -> Int?  { return value(forKey: attributeName$) as? Int }
   func valueForAttribute＃f(_ attributeName$: String) -> Float?  { return value(forKey: attributeName$) as? Float }
   func valueForAttribute＃d(_ attributeName$: String) -> Double?  { return value(forKey: attributeName$) as? Double }
   func valueForAttributeß(_ attributeName$: String) -> UIImage?  { if let imageß = value(forKey: attributeName$) as? Data { return UIImage(data: imageß) } else { return nil } }
   func valueForAttribute㊐(_ attributeName$: String) -> Date?  { return value(forKey: attributeName$) as? Date }
}


// MARK: MAPS —————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class Location＆: CustomDebugStringConvertible {
   var name$: String?
   var coordinate＃²: CLLocationCoordinate2D
   var streetAndNumber$: String?
   var city$: String?
   var zipCode$: String?
   var state$: String?
   var country$: String?
   
   init(coordinate＃²: CLLocationCoordinate2D = CLLocationCoordinate2D(), name$: String? = nil, address$: String? = nil, city$: String? = nil, zipCode$: String? = nil, state$: String? = nil, country$: String? = nil) {
      self.name$ = name$
      self.coordinate＃² = coordinate＃²
      self.streetAndNumber$ = address$
      self.city$ = city$
      self.zipCode$ = zipCode$
      self.state$ = state$
      self.country$ = country$
   }
   
   func fetchAddress(completionƒ: (()->())? ) { HKMaps＋.FetchLocationAddress(location＆: self, completionƒ: completionƒ) }
   
   var addressForPrint$🅣: (line1$: String, line2$: String) {
      var output$: (line1$: String, line2$: String)
         output$.line1$ = streetAndNumber$.isNilⓑ() ? "" : streetAndNumber$!
         output$.line2$ = city$.isNilⓑ() ? "" : city$!
         if state$.isNotNilⓑ() && zipCode$.isNotNilⓑ() { output$.line2$ += ", " }
         output$.line2$ += state$.isNilⓑ() ? "" : state$!
         output$.line2$ += zipCode$.isNilⓑ() ? "" : " \(zipCode$!)"
      return output$
   }
   var hasAddressⓑ: Bool { return (addressForPrint$🅣.line1$ == "" && addressForPrint$🅣.line2$ == "") }
   
   var debugDescription: String { return "Country = \(country$)\nState = \(state$)\nCity = \(city$)\nZipCode = \(zipCode$)\nAddress = \(streetAndNumber$)" }
}

class HKMaps＋ {
 /*
    In order for the LocationManger to be able to request user's permission for tracking, the following keys must be added to the info.plist at Project's properties -> Custom iOS Target Properties -> info:
    NSLocationWhenInUseUsageDescription: String  |&  NSLocationAlwaysUsageDescription: String
   
   the viewController that will be the CLLocationManagerDelegate must implement the function locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]),
      that will be called by the locationManager when it updates info
   in order to draw a polyline the two last locations must be read
 */
   
   enum trackingAccuracies🅔 {
      case navigation
      case best
      case m10
      case m100
      case km1
      case km3
   }
   
   enum authorizationTypes🅔 {
      case active
      case permanent
   }
   
   enum authorizationStatusTypes🅔 {
      case always
      case foreground
      case unDetermined
      case restricted
      case denied
   }
   
   static let LocationManager＆ = CLLocationManager()
   static var CurrentLocation＆ = CLLocation()
   
   static var LocationTrackingEnabledⓑ＋: Bool { get { return CLLocationManager.locationServicesEnabled() } }
   
   class func AuthorizationStatus🅔() -> authorizationStatusTypes🅔 {
      switch CLLocationManager.authorizationStatus() {
         case .notDetermined: return .unDetermined
         case .restricted: return .restricted
         case .denied: return .denied
         case .authorizedAlways: return .always
         case .authorizedWhenInUse: return .foreground
      }
   }
   
   class func ActivateLocationTracking(delegate＆: CLLocationManagerDelegate, accuracy🅔: trackingAccuracies🅔 = .best, authorizationType🅔: authorizationTypes🅔 = .active) {
      LocationManager＆.delegate = delegate＆
      switch accuracy🅔 {
         case .navigation: LocationManager＆.desiredAccuracy = kCLLocationAccuracyBestForNavigation
         case .best: LocationManager＆.desiredAccuracy = kCLLocationAccuracyBest
         case .m10: LocationManager＆.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
         case .m100: LocationManager＆.desiredAccuracy = kCLLocationAccuracyHundredMeters
         case .km1: LocationManager＆.desiredAccuracy = kCLLocationAccuracyKilometer
         case .km3: LocationManager＆.desiredAccuracy = kCLLocationAccuracyThreeKilometers
      }
      if authorizationType🅔 == .permanent { LocationManager＆.requestAlwaysAuthorization() } else { LocationManager＆.requestWhenInUseAuthorization() }
      LocationManager＆.startUpdatingLocation()
      /*
         authorization requests only prompt user when authorization status is kCLAuthorizationStatusNotDetermined
         to react to authorzation changes the CLLocation manager delegate must implement: locationManagerdidChangeAuthorizationStatus()
      */
   }
   
   class func DeactivateLocationTracking() { LocationManager＆.stopUpdatingLocation() }
   
   class func FetchLocationAddress(location＆: Location＆, completionƒ: (() -> ())? = nil) {
      CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: location＆.coordinate＃².latitude, longitude: location＆.coordinate＃².longitude), completionHandler: { (placemarks＆, error) in
         if error.isNilⓑ() {
            location＆.country$ = placemarks＆![0].country
            location＆.state$ = placemarks＆![0].administrativeArea
            location＆.zipCode$ = placemarks＆![0].postalCode
            location＆.city$ = placemarks＆![0].locality
            let streetName$ = placemarks＆![0].thoroughfare
            let streetNumber$ = placemarks＆![0].subThoroughfare.isNilⓑ() ? "" : placemarks＆![0].subThoroughfare! + " "
            location＆.streetAndNumber$ = streetNumber$ + (streetName$ ?? "")
            completionƒ?()
         } else { print("Error fetching location info: \(error!.localizedDescription)") }
      })
   }
   
   class func generatePrintAddress$(streetAndNumber$: String? = nil, city$: String? = nil, state$: String? = nil, zipCode$: String? = nil) -> String {
      var output$ = streetAndNumber$ ?? ""
      output$ += output$.isEmpty ? "" : ", " + (city$ ?? "")
      output$ += output$.isEmpty ? "" : ", " + (state$ ?? "") + (zipCode$ ?? "")
      return output$
   }
   
}

extension CLLocationManagerDelegate {
   func startTrackingLocation(accuracy🅔: HKMaps＋.trackingAccuracies🅔 = .best, authorizationType🅔: HKMaps＋.authorizationTypes🅔 = .active) { HKMaps＋.ActivateLocationTracking(delegate＆: self, accuracy🅔: accuracy🅔, authorizationType🅔: authorizationType🅔) }
   func stopTrackingLocation() { HKMaps＋.DeactivateLocationTracking() }
}



// MARK: HARDWARE —————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class HKDevice＋ {

   static let DeviceTypes$🅐 = [
      "iPod5,1": "iPod Touch 5",
      "iPhone3,1":  "iPhone 4", "iPhone3,2": "iPhone 4", "iPhone3,3": "iPhone 4",
      "iPhone4,1": "iPhone 4S",
      "iPhone5,1": "iPhone 5", "iPhone5,2": "iPhone 5",
      "iPhone5,3": "iPhone 5C", "iPhone5,4": "iPhone 5C",
      "iPhone6,1": "iPhone 5S", "iPhone6,2": "iPhone 5S",
      "iPhone7,2": "iPhone 6",
      "iPhone7,1": "iPhone 6 Plus",
      "iPad2,1": "iPad 2", "iPad2,2": "iPad 2", "iPad2,3": "iPad 2", "iPad2,4": "iPad 2",
      "iPad3,1": "iPad 3", "iPad3,2": "iPad 3", "iPad3,3": "iPad 3",
      "iPad3,4": "iPad 4", "iPad3,5": "iPad 4", "iPad3,6": "iPad 4",
      "iPad4,1": "iPad Air", "iPad4,2": "iPad Air", "iPad4,3": "iPad Air",
      "iPad5,1": "iPad Air 2", "iPad5,3": "iPad Air 2", "iPad5,4": "iPad Air 2",
      "iPad2,5": "iPad Mini", "iPad2,6": "iPad Mini", "iPad2,7": "iPad Mini",
      "iPad4,4": "iPad Mini", "iPad4,5": "iPad Mini", "iPad4,6": "iPad Mini",
      "iPad4,7": "iPad Mini", "iPad4,8": "iPad Mini", "iPad4,9": "iPad Mini",
      "x86_64": "Simulator", "i386": "Simulator"
   ]
}

extension UIDevice { // doesn't work on Swift 2.2
   
   var modelName$: String {
      var systemInfo🅢 = utsname()
      uname(&systemInfo🅢)
      let machine = systemInfo🅢.machine
      let mirror🅢 = Mirror(reflecting: machine)
      var identifier$ = ""
      for child in mirror🅢.children where child.value as? Int != 0 { identifier$.append(String(UnicodeScalar(UInt8(child.value as! Int)))) }
      return HKDevice＋.DeviceTypes$🅐[identifier$] ?? identifier$
   }
}

extension AVPlayer {
   
   func captureSnapshotⓘ(atTime＃f time＃f: Float64? = nil) -> UIImage? {
      guard let assetⓐ = currentItem?.asset else { return nil }
      let imageGenerator＆ = AVAssetImageGenerator(asset: assetⓐ)
      imageGenerator＆.appliesPreferredTrackTransform = true
      imageGenerator＆.requestedTimeToleranceAfter = kCMTimeZero
      imageGenerator＆.requestedTimeToleranceBefore = kCMTimeZero
      do {
         let imageⒾ = try imageGenerator＆.copyCGImage(at: time＃f.isNilⓑ() ? (currentItem?.duration)! : CMTimeMakeWithSeconds(time＃f!, 1), actualTime: nil)
         let imageⓘ = UIImage(cgImage: imageⒾ)
         return imageⓘ
      } catch { return nil }
   }
}


extension AVPlayerLayer {
   
   var visibleⓑ: Bool { get { return !isHidden } set { isHidden = !newValue } }
   
   func setFrame＋(xⓖ: CGFloat? = nil, ＋Xⓑ: Bool = false, yⓖ: CGFloat? = nil, ＋Yⓑ: Bool = false, widthⓖ: CGFloat? = nil, ＋Wⓑ: Bool = false, heightⓖ: CGFloat? = nil, ＋Hⓑ: Bool = false) {
      var _xⓖ: CGFloat, _yⓖ: CGFloat, _widthⓖ : CGFloat, _heightⓖ: CGFloat
      _xⓖ = xⓖ.isNilⓑ() ? frame.origin.x : ( ＋Xⓑ ? frame.origin.x + xⓖ! : xⓖ! )
      _yⓖ = yⓖ.isNilⓑ() ? frame.origin.y : ( ＋Yⓑ ? frame.origin.y + yⓖ! : yⓖ! )
      _widthⓖ = widthⓖ.isNilⓑ() ? frame.width : ( ＋Wⓑ ? frame.width + widthⓖ! : widthⓖ! )
      _heightⓖ = heightⓖ.isNilⓑ() ? frame.height : ( ＋Hⓑ ? frame.height + heightⓖ! : heightⓖ! )
      frame = CGRect(x: _xⓖ, y: _yⓖ, width: _widthⓖ, height: _heightⓖ)
   }
   
   func setFrame＊(xⓖ: CGFloat? = nil, ＊Xⓑ: Bool = false, yⓖ: CGFloat? = nil, ＊Yⓑ: Bool = false, widthⓖ: CGFloat? = nil, ＊Wⓑ: Bool = false, heightⓖ: CGFloat? = nil, ＊Hⓑ: Bool = false) {
      var _xⓖ: CGFloat, _yⓖ: CGFloat, _widthⓖ : CGFloat, _heightⓖ: CGFloat
      _xⓖ = xⓖ.isNilⓑ() ? frame.origin.x : ( ＊Xⓑ ? frame.origin.x * xⓖ! : xⓖ! )
      _yⓖ = yⓖ.isNilⓑ() ? frame.origin.y : ( ＊Yⓑ ? frame.origin.y * yⓖ! : yⓖ! )
      _widthⓖ = widthⓖ.isNilⓑ() ? frame.width : ( ＊Wⓑ ? frame.width * widthⓖ! : widthⓖ! )
      _heightⓖ = heightⓖ.isNilⓑ() ? frame.height : ( ＊Hⓑ ? frame.height * heightⓖ! : heightⓖ! )
      frame = CGRect(x: _xⓖ, y: _yⓖ, width: _widthⓖ, height: _heightⓖ)
   }
   
   func transformFrame(＋Xⓖ: CGFloat? = nil, ＊Xⓖ: CGFloat? = nil, ＋Yⓖ: CGFloat? = nil, ＊Yⓖ: CGFloat? = nil, ＋widthⓖ: CGFloat? = nil, ＊widthⓖ: CGFloat? = nil, ＋heightⓖ: CGFloat? = nil, ＊heightⓖ: CGFloat? = nil) {
      var _xⓖ: CGFloat, _yⓖ: CGFloat, _widthⓖ : CGFloat, _heightⓖ: CGFloat
      _xⓖ = frame.origin.x ; _yⓖ = frame.origin.y ; _widthⓖ = frame.width ; _heightⓖ = frame.height
      if ＋Xⓖ.isNotNilⓑ() { _xⓖ += ＋Xⓖ! } ; if ＊Xⓖ.isNotNilⓑ() { _xⓖ *= ＊Xⓖ! }
      if ＋Yⓖ.isNotNilⓑ() { _yⓖ += ＋Yⓖ! } ; if ＊Yⓖ.isNotNilⓑ() { _yⓖ *= ＊Yⓖ! }
      if ＋widthⓖ.isNotNilⓑ() { _widthⓖ += ＋widthⓖ! } ; if ＊widthⓖ.isNotNilⓑ() { _widthⓖ *= ＊widthⓖ! }
      if ＋heightⓖ.isNotNilⓑ() { _heightⓖ += ＋heightⓖ! } ; if ＊heightⓖ.isNotNilⓑ() { _heightⓖ *= ＊heightⓖ! }
      frame = CGRect(x: _xⓖ, y: _yⓖ, width: _widthⓖ, height: _heightⓖ)
   }
   
   func centerInObjectFrame(object﹖: AnyObject) {
      if let castView＆ = object﹖ as? UIView {
         let containerFrameⓖ⁴ = castView＆.frame
         let Wⓖ = containerFrameⓖ⁴.width, Hⓖ = containerFrameⓖ⁴.height
         var wⓖ = frame.width, hⓖ = frame.height
         if wⓖ > Wⓖ || hⓖ > Wⓖ {
            let wExcessⓖ = wⓖ - Wⓖ, hExcessⓖ = hⓖ - Wⓖ
            if wExcessⓖ > hExcessⓖ {
               let scaleFactorⓖ = wⓖ / Wⓖ
               wⓖ = Wⓖ
               hⓖ = hⓖ / scaleFactorⓖ
            } else {
               let scaleFactorⓖ = hⓖ / Hⓖ
               hⓖ = Hⓖ
               wⓖ = wⓖ / scaleFactorⓖ
            }
         }
         frame = CGRect(x: (Wⓖ - wⓖ) / 2, y: (Hⓖ - hⓖ) / 2, width: wⓖ, height: hⓖ)
      }
   }
   
   func centerAroundObjectBounds(object﹖: AnyObject) {
      if let castView＆ = object﹖ as? UIView {
         let containedBoundsⓖ⁴ = castView＆.bounds
         let wⓖ = containedBoundsⓖ⁴.width, hⓖ = containedBoundsⓖ⁴.height
         let Wⓖ = frame.width, Hⓖ = frame.height
         if Wⓖ < wⓖ || Hⓖ < hⓖ { return }
         frame = CGRect(x: -(Wⓖ - wⓖ) / 2, y: -(Hⓖ - hⓖ) / 2, width: Wⓖ, height: Hⓖ)
      }
   }
   
   func positionInPoint(xⓖ pointXⓖ: CGFloat, yⓖ pointYⓖ: CGFloat) {
      let xⓖ = pointXⓖ - self.frame.width / 2
      let yⓖ = pointYⓖ - self.frame.height / 2
      self.setFrame＋(xⓖ: xⓖ, yⓖ: yⓖ)
   }
   
   func positionInPoint(_ pointⓖ²: CGPoint) {
      let xⓖ = pointⓖ².x - self.frame.width / 2
      let yⓖ = pointⓖ².y - self.frame.height / 2
      self.setFrame＋(xⓖ: xⓖ, yⓖ: yⓖ)
   }
   
   func pointIsInFrameⓑ(xⓖ pointXⓖ: CGFloat, yⓖ pointYⓖ: CGFloat) -> Bool { return ( pointXⓖ > frame.origin.x && pointXⓖ < frame.origin.x + frame.width && pointYⓖ > frame.origin.y && pointYⓖ < frame.origin.y + frame.height) }
   
   func containsPointⓑ(_ pointⓖ²: CGPoint) -> Bool { return self.frame.contains(pointⓖ²) }
   
}

extension AVCaptureVideoPreviewLayer {
   
   var visibleⓑ: Bool { get { return !isHidden } set { isHidden = !newValue } }
   
   func setFrame＋(xⓖ: CGFloat? = nil, ＋Xⓑ: Bool = false, yⓖ: CGFloat? = nil, ＋Yⓑ: Bool = false, widthⓖ: CGFloat? = nil, ＋Wⓑ: Bool = false, heightⓖ: CGFloat? = nil, ＋Hⓑ: Bool = false) {
      var _xⓖ: CGFloat, _yⓖ: CGFloat, _widthⓖ : CGFloat, _heightⓖ: CGFloat
      _xⓖ = xⓖ.isNilⓑ() ? frame.origin.x : ( ＋Xⓑ ? frame.origin.x + xⓖ! : xⓖ! )
      _yⓖ = yⓖ.isNilⓑ() ? frame.origin.y : ( ＋Yⓑ ? frame.origin.y + yⓖ! : yⓖ! )
      _widthⓖ = widthⓖ.isNilⓑ() ? frame.width : ( ＋Wⓑ ? frame.width + widthⓖ! : widthⓖ! )
      _heightⓖ = heightⓖ.isNilⓑ() ? frame.height : ( ＋Hⓑ ? frame.height + heightⓖ! : heightⓖ! )
      frame = CGRect(x: _xⓖ, y: _yⓖ, width: _widthⓖ, height: _heightⓖ)
   }
   
   func setFrame＊(xⓖ: CGFloat? = nil, ＊Xⓑ: Bool = false, yⓖ: CGFloat? = nil, ＊Yⓑ: Bool = false, widthⓖ: CGFloat? = nil, ＊Wⓑ: Bool = false, heightⓖ: CGFloat? = nil, ＊Hⓑ: Bool = false) {
      var _xⓖ: CGFloat, _yⓖ: CGFloat, _widthⓖ : CGFloat, _heightⓖ: CGFloat
      _xⓖ = xⓖ.isNilⓑ() ? frame.origin.x : ( ＊Xⓑ ? frame.origin.x * xⓖ! : xⓖ! )
      _yⓖ = yⓖ.isNilⓑ() ? frame.origin.y : ( ＊Yⓑ ? frame.origin.y * yⓖ! : yⓖ! )
      _widthⓖ = widthⓖ.isNilⓑ() ? frame.width : ( ＊Wⓑ ? frame.width * widthⓖ! : widthⓖ! )
      _heightⓖ = heightⓖ.isNilⓑ() ? frame.height : ( ＊Hⓑ ? frame.height * heightⓖ! : heightⓖ! )
      frame = CGRect(x: _xⓖ, y: _yⓖ, width: _widthⓖ, height: _heightⓖ)
   }
   
   func transformFrame(＋Xⓖ: CGFloat? = nil, ＊Xⓖ: CGFloat? = nil, ＋Yⓖ: CGFloat? = nil, ＊Yⓖ: CGFloat? = nil, ＋widthⓖ: CGFloat? = nil, ＊widthⓖ: CGFloat? = nil, ＋heightⓖ: CGFloat? = nil, ＊heightⓖ: CGFloat? = nil) {
      var _xⓖ: CGFloat, _yⓖ: CGFloat, _widthⓖ : CGFloat, _heightⓖ: CGFloat
      _xⓖ = frame.origin.x ; _yⓖ = frame.origin.y ; _widthⓖ = frame.width ; _heightⓖ = frame.height
      if ＋Xⓖ.isNotNilⓑ() { _xⓖ += ＋Xⓖ! } ; if ＊Xⓖ.isNotNilⓑ() { _xⓖ *= ＊Xⓖ! }
      if ＋Yⓖ.isNotNilⓑ() { _yⓖ += ＋Yⓖ! } ; if ＊Yⓖ.isNotNilⓑ() { _yⓖ *= ＊Yⓖ! }
      if ＋widthⓖ.isNotNilⓑ() { _widthⓖ += ＋widthⓖ! } ; if ＊widthⓖ.isNotNilⓑ() { _widthⓖ *= ＊widthⓖ! }
      if ＋heightⓖ.isNotNilⓑ() { _heightⓖ += ＋heightⓖ! } ; if ＊heightⓖ.isNotNilⓑ() { _heightⓖ *= ＊heightⓖ! }
      frame = CGRect(x: _xⓖ, y: _yⓖ, width: _widthⓖ, height: _heightⓖ)
   }
   
   func centerInObjectFrame(object﹖: AnyObject) {
      if let castView＆ = object﹖ as? UIView {
         let containerFrameⓖ⁴ = castView＆.frame
         let Wⓖ = containerFrameⓖ⁴.width, Hⓖ = containerFrameⓖ⁴.height
         var wⓖ = frame.width, hⓖ = frame.height
         if wⓖ > Wⓖ || hⓖ > Wⓖ {
            let wExcessⓖ = wⓖ - Wⓖ, hExcessⓖ = hⓖ - Wⓖ
            if wExcessⓖ > hExcessⓖ {
               let scaleFactorⓖ = wⓖ / Wⓖ
               wⓖ = Wⓖ
               hⓖ = hⓖ / scaleFactorⓖ
            } else {
               let scaleFactorⓖ = hⓖ / Hⓖ
               hⓖ = Hⓖ
               wⓖ = wⓖ / scaleFactorⓖ
            }
         }
         frame = CGRect(x: (Wⓖ - wⓖ) / 2, y: (Hⓖ - hⓖ) / 2, width: wⓖ, height: hⓖ)
      }
   }
   
   func centerAroundObjectBounds(object﹖: AnyObject) {
      if let castView＆ = object﹖ as? UIView {
         let containedBoundsⓖ⁴ = castView＆.bounds
         let wⓖ = containedBoundsⓖ⁴.width, hⓖ = containedBoundsⓖ⁴.height
         let Wⓖ = frame.width, Hⓖ = frame.height
         if Wⓖ < wⓖ || Hⓖ < hⓖ { return }
         frame = CGRect(x: -(Wⓖ - wⓖ) / 2, y: -(Hⓖ - hⓖ) / 2, width: Wⓖ, height: Hⓖ)
      }
   }
   
   func positionInPoint(xⓖ pointXⓖ: CGFloat, yⓖ pointYⓖ: CGFloat) {
      let xⓖ = pointXⓖ - self.frame.width / 2
      let yⓖ = pointYⓖ - self.frame.height / 2
      self.setFrame＋(xⓖ: xⓖ, yⓖ: yⓖ)
   }
   
   func positionInPoint(_ pointⓖ²: CGPoint) {
      let xⓖ = pointⓖ².x - self.frame.width / 2
      let yⓖ = pointⓖ².y - self.frame.height / 2
      self.setFrame＋(xⓖ: xⓖ, yⓖ: yⓖ)
   }
   
   func pointIsInFrameⓑ(xⓖ pointXⓖ: CGFloat, yⓖ pointYⓖ: CGFloat) -> Bool { return ( pointXⓖ > frame.origin.x && pointXⓖ < frame.origin.x + frame.width && pointYⓖ > frame.origin.y && pointYⓖ < frame.origin.y + frame.height) }
   
   func containsPointⓑ(_ pointⓖ²: CGPoint) -> Bool { return self.frame.contains(pointⓖ²) }
   
}

// MARK: File manager


extension FileManager {
   
   func fileExistsⓑ(_ path$: String) -> Bool { return fileManager＆.fileExists(atPath: path$, isDirectory: nil) }
   
   func folderExistsⓑ(_ path$: String) -> Bool {
      var isDirectoryⓑ : ObjCBool = true
      return fileManager＆.fileExists(atPath: path$, isDirectory: &isDirectoryⓑ)
   }

   func clearDirectory(atPath$ path$: String) {
      do {
         let files$🅐 = try fileManager＆.contentsOfDirectory(atPath: path$)
         for file$ in files$🅐 { try fileManager＆.removeItem(atPath: path$ + file$) }
      } catch { print("ヂレクロリは空っぽです。消さない") ; return }
   }
   
}



/*
NSUUID *myDevice = [NSUUID UUID];
NSString *deviceUDID = myDevice.UUIDString;
NSString *deviceName = myDevice.Name;
NSString *deviceSystemName = myDevice.systemName;
NSString *deviceOSVersion = myDevice.systemVersion;
NSString *deviceModel = myDevice.model;
*/




// MARK: OLD EXPERIMENTS


//   func objectWithContextID(contextID$: String) -> UIView? { // since all objects will be subClasses of UIView, this trick works, and the properties of the returned object can be managed. In case of AnyObject you can't do SHIT.
//      for subView in subviews {                        // ... but POLYMORPHISM would have fixed the issue in a safer and more orthodox manner. But WE MUST KNOW WHAT KIND of object will be RETURNED
//         if subView is HikarianUIView { let idObject: HikarianUIView = subView as! HikarianUIView; if idObject.contextID$ == contextID$ { return idObject } }
//         if subView is HikarianUILabel { let idObject: HikarianUILabel = subView as! HikarianUILabel; if idObject.contextID$ == contextID$ { return idObject } }
//         if subView is HikarianUIImage { let idObject: HikarianUIImage = subView as! HikarianUIImage; if idObject.contextID$ == contextID$ { return idObject } }
//         if subView is HikarianUIButton { let idObject: HikarianUIButton = subView as! HikarianUIButton; if idObject.contextID$ == contextID$ { return idObject } }
//      }
//      return nil
//   }
//   func objectsWithContextIDs🅐(contextIDs$: [String]) -> [UIView]? { // since all objects will be subClasses of UIView, this trick works, and the properties of the returned object can be managed. In case of AnyObject you can't do SHIT.
//      var objects🅐 = [UIView]()
//      for (_, contextID$) in contextIDs$.enumerate() {
//         for subView in subviews {
//            if subView is HikarianUIView { let hikarianSubView = subView as! HikarianUIView; if hikarianSubView.contextID$ == contextID$ { objects🅐.append(hikarianSubView) } }
//            if subView is HikarianUILabel { let hikarianSubView = subView as! HikarianUILabel; if hikarianSubView.contextID$ == contextID$ { objects🅐.append(hikarianSubView) } }
//            if subView is HikarianUIImage { let hikarianSubView = subView as! HikarianUIImage; if hikarianSubView.contextID$ == contextID$ { objects🅐.append(hikarianSubView) } }
//            if subView is HikarianUIButton { let hikarianSubView = subView as! HikarianUIButton; if hikarianSubView.contextID$ == contextID$ { objects🅐.append(hikarianSubView) } }
//         }
//      }
//      return objects🅐.count == 0 ? nil : objects🅐
//   }
//   func _objectWithContextID(contextID: String) -> NSObject? { // since all objects will be subClasses of UIView, this trick works, and the properties of the returned object can be managed. In case of AnyObject you can't do SHIT.
//      for subView in subviews {                        // ... but POLYMORPHISM would have fixed the issue in a safer and more orthodox manner. But WE MUST KNOW WHAT KIND of object will be RETURNED
//         if subView is HikarianUIView { let idObject: HikarianUIView = subView as! HikarianUIView; if idObject.contextID == contextID { return idObject } }
//         //         if subView is HikarianUIImageView { let idObject: HikarianUIImageView = subView as! HikarianUIImageView; if idObject.contextID == contextID { return idObject } }
//         if subView is HikarianUIImage { let idObject: HikarianUIImage = subView as! HikarianUIImage; if idObject.contextID == contextID { return idObject } }
//         if subView is HikarianUIButton { let idObject: HikarianUIButton = subView as! HikarianUIButton; if idObject.contextID == contextID { return idObject } }
//      }
//      return nil
//   }

// DO THIESE MAKE ANY SENSE??
//   internal func viewWithContextID(contextID$: String) -> HikarianUIView? { // since all objects will be subClasses of UIView, this trick works, and the properties of the returned object can be managed. In case of AnyObject you can't do SHIT.
//      for subView in subviews { let idObject: HikarianUIView = subView as! HikarianUIView; if idObject.contextID$ == contextID$ { return idObject } }
//      return nil
//   }
//   internal func tableViewWithContextID(contextID$: String) -> HikarianUITableView? { // since all objects will be subClasses of UIView, this trick works, and the properties of the returned object can be managed. In case of AnyObject you can't do SHIT.
//      for subView in subviews { let idObject: HikarianUITableView = subView as! HikarianUITableView; if idObject.contextID$ == contextID$ { return idObject } }
//      return nil
//   }
//   internal func imageViewWithContextID(contextID: String) -> HikarianUIImageView? { // since all objects will be subClasses of UIView, this trick works, and the properties of the returned object can be managed. In case of AnyObject you can't do SHIT.
//      for subView in subviews { let idObject: HikarianUIImageView = subView as! HikarianUIImageView; if idObject.contextID == contextID { return idObject } }
//      return nil
//   }
//   internal func imageWithContextID(contextID$: String) -> HikarianUIImage? { // since all objects will be subClasses of UIView, this trick works, and the properties of the returned object can be managed. In case of AnyObject you can't do SHIT.
//      for subView in subviews { let idObject: HikarianUIImage = subView as! HikarianUIImage; if idObject.contextID$ == contextID$ { return idObject } }
//      return nil
//   }
//   internal func buttonWithContextID(contextID$: String) -> HikarianUIButton? { // since all objects will be subClasses of UIView, this trick works, and the properties of the returned object can be managed. In case of AnyObject you can't do SHIT.
//      for subView in subviews { let idObject: HikarianUIButton = subView as! HikarianUIButton; if idObject.contextID$ == contextID$ { return idObject } }
//      return nil
//   }

//   func objectWithContextID(contextID: String) -> (object＆: AnyObject, objectClassName: String) {
//      for subView in subviews {
//         let objectClassAsString = subView.dynamicType.description()
//         let objectClass =
//         let idObject: HikarianUIView = subView as! HikarianUIView
//         if subView.contextID
//      }
//   }


//   func slideForKeyboardAndReturnOffset(notification notification: NSNotification, duration: NSTimeInterval = 0.4) -> CGFloat { // if the firstResponder is a UITextField of a UITextView, it slides the view up by the height of the keyboard and returns it
//      var keyboardHeight = CGFloat()
//      if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//         keyboardHeight = keyboardSize.height
//         if let responder = firstResponder as? UIView {
//            if (responder.className == "UITextField") || (responder.className == "UITextView") || (responder.className == "HikarianUITextView") || (responder.className == "HikarianUITextView") {
//               if responder.absoluteOrigin.y + responder.frame.height >= (responder.window!.frame.height - keyboardHeight) {
//                  UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { self.frame =  CGRect(x: self.frame.origin.x, y: self.frame.origin.y - keyboardHeight, width: self.frame.width, height: self.frame.height) }, completion: nil)
//               }
//            }
//         }
//      }
//      return keyboardHeight
//   }
