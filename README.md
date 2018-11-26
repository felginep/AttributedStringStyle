# AttributedStringStyle

[![Version](https://img.shields.io/cocoapods/v/AttributedStringStyle.svg?style=flat)](https://cocoapods.org/pods/AttributedStringStyle)
[![License](https://img.shields.io/cocoapods/l/AttributedStringStyle.svg?style=flat)](https://cocoapods.org/pods/AttributedStringStyle)
[![Platform](https://img.shields.io/cocoapods/p/AttributedStringStyle.svg?style=flat)](https://cocoapods.org/pods/AttributedStringStyle)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9.0+
- Swift 4.2

## Installation

AttributedStringStyle is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AttributedStringStyle'
```

## How to use it

Define some abstract style anywhere in your app. For instance.

```swift
enum Style {
    case regular
    case highlighted
}
```

Once your style is defined we have two tools at your disposal:
- `AttributedStringBuilder` that is helpful to create attributed string with styles for range of characters
- `AttributedStringStyler` that defines which visual attributes to apply for each style

To create your attributed string and focus on the semantic and not the display, use the builder like so:

```swift
let content = "A simple string"
let builder = AttributedStringBuilder<Style>(string: content)
builder.setStyle(.regular)
let range = NSString(string: content).range(of: "simple")
builder.addStyle(.highlighted, range: range)
let semanticAttributedString = builder.build()
```

The attributed string has no visual attributes but semantics ones.

![Simple String Semantics](https://raw.githubusercontent.com/felginep/AttributedStringStyle/master/Assets/simple_string_semantic.png)

Once your semantic content is defined, you can use the styler to create a new attributed string with visual attributes.

```swift
let styler = AttributedStringStyler<Style>()
styler.register(
    attributes: [
        .font: UIFont.systemFont(ofSize: 14),
        .foregroundColor: UIColor.gray
    ],
    forStyle: .regular
)
styler.register(
    attributes: [
        .font: UIFont.boldSystemFont(ofSize: 14),
        .foregroundColor: UIColor.black
    ],
    forStyle: .highlighted
)

let visualAttributedString = semanticAttributedString.styled(with: styler)
```

This time the result is visual.

![Simple String Visual](https://raw.githubusercontent.com/felginep/AttributedStringStyle/master/Assets/simple_string_visual.png)

## Author

[Pierre Felgines](https://twitter.com/PierreFelgines)

## License

AttributedStringStyle is available under the MIT license. See the LICENSE file for more info.
