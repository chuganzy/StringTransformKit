//
//  StringTransformKit.swift
//  StringTransformKit
//
//  Created by Takeru Chuganji on 9/24/15.
//  Copyright © 2015 Takeru Chuganji. All rights reserved.
//

public extension String {
    public enum TransformType {
        case LatinToKatakana
        case LatinToHiragana
        case LatinToHangul
        case LatinToArabic
        case LatinToHebrew
        case LatinToThai
        case LatinToCyrillic
        case LatinToGreek
        case ToLatin
        case MandarinToLatin
        case HiraganaToKatakana
        case FullwidthToHalfwidth
        case ToXMLHex
        case ToUnicodeName
        case StripCombiningMarks
        @available(iOS 2.0, *)
        case StripDiacritics
    }
    
    public func stringByApplyingTransform(transformType: TransformType, reverse: Bool = false) -> String {
        let cfTransform: CFString
        switch transformType {
        case .LatinToKatakana:
            cfTransform = kCFStringTransformLatinKatakana
        case .LatinToHiragana:
            cfTransform = kCFStringTransformLatinHiragana
        case .LatinToHangul:
            cfTransform = kCFStringTransformLatinHangul
        case .LatinToArabic:
            cfTransform = kCFStringTransformLatinArabic
        case .LatinToHebrew:
            cfTransform = kCFStringTransformLatinHebrew
        case .LatinToThai:
            cfTransform = kCFStringTransformLatinThai
        case .LatinToCyrillic:
            cfTransform = kCFStringTransformLatinCyrillic
        case .LatinToGreek:
            cfTransform = kCFStringTransformLatinGreek
        case .ToLatin:
            cfTransform = kCFStringTransformToLatin
        case .MandarinToLatin:
            cfTransform = kCFStringTransformMandarinLatin
        case .HiraganaToKatakana:
            cfTransform = kCFStringTransformHiraganaKatakana
        case .FullwidthToHalfwidth:
            cfTransform = kCFStringTransformFullwidthHalfwidth
        case .ToXMLHex:
            cfTransform = kCFStringTransformToXMLHex
        case .ToUnicodeName:
            cfTransform = kCFStringTransformToUnicodeName
        case .StripCombiningMarks:
            cfTransform = kCFStringTransformStripCombiningMarks
        case .StripDiacritics:
            cfTransform = kCFStringTransformStripDiacritics
        }
        let cfString = NSMutableString(string: self) as CFMutableString
        CFStringTransform(cfString, nil, cfTransform, reverse)
        return cfString as String
    }
    
    public func stringByApplyingKanaToHepburnTransform() -> String {
        let replace = [
            "che": "chie",
            "je": "jie",
            "ti": "tei",
            "di": "dei",
            "wi": "i",
            "we": "e",
            "fa": "fua",
            "fi": "fui",
            "fe": "fue",
            "fo": "fuo",
            "nb": "mb",
            "nm": "mm",
            "np": "mp",
            "oo": "o",
            "ou": "o",
            "uu": "u",
            "v": "b",
            "ā": "a",
            "ī": "i",
            "ū": "u",
            "ē": "e",
            "ō": "o",
            "'": "",
            "~": "",
        ]
        let katakanaString = stringByApplyingTransform(.HiraganaToKatakana)
        let latinString = replace.reduce(katakanaString.stringByApplyingTransform(.LatinToKatakana, reverse: true)) { (current, pair) -> String in
            return current.stringByReplacingOccurrencesOfString(pair.0, withString: pair.1)
        }
        if katakanaString.characters.last == "オ" {
            return latinString + "o"
        }
        return latinString
    }
    
    public func stringByApplyingKanjiToLatinTransform(locale: NSLocale? = nil) -> String {
        let tokenizer = CFStringTokenizerCreate(nil, self, CFRangeMake(0, CFStringGetLength(self)), kCFStringTokenizerUnitWord, locale)
        var result = CFStringTokenizerAdvanceToNextToken(tokenizer)
        var latinString = ""
        while result != .None {
            if let string = CFStringTokenizerCopyCurrentTokenAttribute(tokenizer, kCFStringTokenizerAttributeLatinTranscription) as? String {
                latinString += string
            }
            result = CFStringTokenizerAdvanceToNextToken(tokenizer)
        }
        return latinString
    }
}
