//
//  StringTransformKit.swift
//  StringTransformKit
//
//  Created by Takeru Chuganji on 9/24/15.
//  Copyright © 2015 Takeru Chuganji. All rights reserved.
//

public extension String {
    public enum Transform {
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
    
    public func stringByApplyingTransform(transform: Transform, reverse: Bool = false) -> String {
        let cfTransform: CFString
        switch transform {
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
    
    public func stringByApplyingLatinToHepburnTransform() -> String {
        let replace = [
            "WI": "I",
            "WE": "E",
            "'": "",
            "JE": "JIE",
            "CHE": "CHIE",
            "TI": "TEI",
            "DI": "DEI",
            "~": "",
            "FA": "FUA",
            "FI": "FUI",
            "FE": "FUE",
            "FO": "FUO",
            "V": "B",
            "Ā": "A",
            "Ī": "I",
            "Ū": "U",
            "Ē": "E",
            "Ō": "O",
            "NB": "MB",
            "NM": "MM",
            "NP": "MP",
            "OO": "O",
            "OU": "O",
            "UU": "U",
        ]
        var retValue = self
        for (key, value) in replace {
            retValue = retValue.stringByReplacingOccurrencesOfString(key, withString: value, options: .CaseInsensitiveSearch)
        }
        return retValue
    }
    
    public func stringByApplyingKanjiToLatinTransform(locale: NSLocale) -> String {
        let tokenizer = CFStringTokenizerCreate(nil, self, CFRangeMake(0, CFStringGetLength(self)), kCFStringTokenizerUnitWord, locale)
        var result = CFStringTokenizerAdvanceToNextToken(tokenizer)
        var latinString = ""
        while result != .None {
            guard let string = CFStringTokenizerCopyCurrentTokenAttribute(tokenizer, kCFStringTokenizerAttributeLatinTranscription) as? String else {
                continue
            }
            latinString += string
            result = CFStringTokenizerAdvanceToNextToken(tokenizer)
        }
        return latinString
    }
}
