//
//  AttributedStringStyleTests.swift
//  AttributedStringStyleTests
//
//  Created by Pierre Felgines on 23/11/2018.
//

import XCTest
import Quick
import Nimble
import AttributedStringStyle

private enum Style: String, CaseIterable {
    case style1
    case style2
    case style3
}

extension NSAttributedString {

    func verifyAttributes(in range: NSRange,
                          verify: ([NSAttributedString.Key: Any], NSRange) -> Void) {
        let totalRange = NSRange(location: 0, length: self.length)
        var foundRange = NSRange(location: 0, length: 1)
        let attributes = self.attributes(
            at: range.location,
            longestEffectiveRange: &foundRange,
            in: totalRange
        )
        verify(attributes, foundRange)
    }

    fileprivate func verifyStyle(_ style: Style, in range: NSRange) {
        verifyAttributes(in: range) { (attributes, foundRange) in
            expect(attributes[.semanticStyle]).toNot(beNil())
            let foundStyle = attributes[.semanticStyle] as? Style
            expect(foundStyle).to(equal(style))
            expect(foundRange).to(equal(range))
        }
    }

    fileprivate func verifyStyle(_ style: Style) {
        verifyStyle(style, in: fullRange)
    }

    var fullRange: NSRange {
        return NSRange(location: 0, length: self.length)
    }
}

class AttributedStringBuilderTests: QuickSpec {

    override func spec() {

        it("should add one style") {
            // Given
            let string = "Style"
            let builder = AttributedStringBuilder<Style>(string: string)

            // When
            builder.addStyle(.style1)
            let attributedString = builder.build()

            // Then
            attributedString.verifyStyle(.style1)
        }

        it("should set two styles") {
            // Given
            let string = "Style"
            let builder = AttributedStringBuilder<Style>(string: string)

            // When
            builder.setStyle(.style1)
            builder.setStyle(.style2)
            let attributedString = builder.build()

            // Then
            attributedString.verifyStyle(.style2)
        }

        it("should set multiple styles") {
            // Given
            let string = Style.allCases.map { $0.rawValue }.joined(separator: " ")
            let builder = AttributedStringBuilder<Style>(string: string)

            // When
            for style in Style.allCases {
                let styleRange = NSString(string: string).range(of: style.rawValue)
                builder.setStyle(style, range: styleRange)
            }
            let attributedString = builder.build()

            // Then
            for style in Style.allCases {
                let styleRange = NSString(string: string).range(of: style.rawValue)
                attributedString.verifyStyle(style, in: styleRange)
            }
        }

        it("add multiple styles in attributed string") {
            // Given
            let string = Style.allCases.map { $0.rawValue }.joined(separator: " ")
            let input = NSAttributedString(string: string, attributes: [.foregroundColor: UIColor.red])
            let builder = AttributedStringBuilder<Style>(attributedString: input)

            // When
            for style in Style.allCases {
                let styleRange = NSString(string: string).range(of: style.rawValue)
                builder.addStyle(style, range: styleRange)
            }
            let attributedString = builder.build()

            // Then
            for style in Style.allCases {
                let styleRange = NSString(string: string).range(of: style.rawValue)
                attributedString.verifyAttributes(in: styleRange) { (attributes, _) in
                    let keys: [NSAttributedString.Key] = Array(attributes.keys)
                        .sorted { $0.rawValue < $1.rawValue }
                    let expectedKeys: [NSAttributedString.Key] = [.semanticStyle, .foregroundColor]
                        .sorted { $0.rawValue < $1.rawValue }
                    expect(keys).to(equal(expectedKeys))
                }
            }
        }
    }
}
