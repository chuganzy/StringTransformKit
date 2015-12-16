//
//  StringTransformKitTests.swift
//  StringTransformKitTests
//
//  Created by Takeru Chuganji on 9/24/15.
//  Copyright © 2015 Takeru Chuganji. All rights reserved.
//

import XCTest
@testable import StringTransformKit

class StringTransformKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testKanaToHepburnTransform() {
        let test = [
            "なんば": "NAMBA",
            "ほんま": "HOMMA",
            "さんぺい": "SAMPEI",
            "はっとり": "HATTORI",
            "きっかわ": "KIKKAWA",
            "ほっち": "HOTCHI",
            "はっちょう": "HATCHO",
            "せのお": "SENOO",
            "よこお": "YOKOO",
            "おおさか": "OSAKA",
            "おおこうち": "OKOCHI",
            "おおの": "ONO",
            "とおやま": "TOYAMA",
            "たろう": "TARO",
            "かのう": "KANO",
            "ちゅうじょう": "CHUJO",
            "ゆうじ": "YUJI",
            "じんぐう": "JINGU",
            "じょうお": "JOO",
        ]
        test.forEach { (key, value) -> () in
            let transformed = key.stringByApplyingKanaToHepburnTransform().uppercaseString
            XCTAssert(transformed == value, "kana: \(key), expected: \(value), transformed: \(transformed)")
        }
    }
}
