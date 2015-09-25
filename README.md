# StringTransformKit
String Transformation Extensions Supports iOS 8 or Earlier.

```swift
"toukyou".stringByApplyingTransform(.LatinToHiragana, reverse: false)
// => とうきょう

"東京".stringByApplyingKanjiToLatinTransform()
// => toukyou

"トウキョウ".stringByApplyingKanaToHepburnTransform()
// => tokyo
```


## Installation

### CocoaPods

```
use_frameworks!
pod StringTransformKit
```

### Carthage

```
github "hoppenichu/StringTransformKit"
```

### Manual

Add reference of `StringTransformKit.swift` to your project.


## Requirements

- Swift 2
- Xcode 7
