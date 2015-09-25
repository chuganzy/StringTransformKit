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
            "CHE": "CHIE",
            "Che": "Chie",
            "che": "chie",
            
            "JE": "JIE",
            "Je": "Jie",
            "je": "jie",
            
            "TI": "TEI",
            "Ti": "Tei",
            "ti": "tei",
            
            "DI": "DEI",
            "Di": "Dei",
            "di": "dei",
            
            "WI": "I",
            "Wi": "I",
            "wi": "i",
            
            "WE": "E",
            "We": "E",
            "we": "e",
            
            "FA": "FUA",
            "Fa": "Fua",
            "fa": "fua",
            
            "FI": "FUI",
            "Fi": "Fui",
            "fi": "fui",
            
            "FE": "FUE",
            "Fe": "Fue",
            "fe": "fue",
            
            "FO": "FUO",
            "Fo": "Fuo",
            "fo": "fuo",
            
            "NB": "MB",
            "Nb": "Mb",
            "nb": "mb",
            
            "NM": "MM",
            "Nm": "Mm",
            "nm": "mm",
            
            "NP": "MP",
            "Np": "Mp",
            "np": "mp",
            
            "OO": "O",
            "Oo": "O",
            "oo": "o",
            
            "OU": "O",
            "Ou": "O",
            "ou": "o",
            
            "UU": "U",
            "Uu": "U",
            "uu": "u",
            
            "V": "B",
            "v": "b",
            
            "Ā": "A",
            "ā": "a",
            
            "Ī": "I",
            "ī": "i",
            
            "Ū": "U",
            "ū": "u",
            
            "Ē": "E",
            "ē": "e",
            
            "Ō": "O",
            "ō": "o",
            
            "'": "",
            "~": "",
        ]
        var latinString = self.stringByApplyingTransform(.HiraganaToKatakana).stringByApplyingTransform(.LatinToKatakana, reverse: true)
        for (key, value) in replace {
            latinString = latinString.stringByReplacingOccurrencesOfString(key, withString: value)
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
