//
//  AttributedStringStyleTests.swift
//  AttributedStringStyleTests
//
//  Created by Pierre Felgines on 23/11/2018.
//

import XCTest
import AttributedStringStyle

private enum Style: String, CaseIterable {
    case style1
    case style2
    case style3
}

extension NSAttributedString {
    fileprivate func verifyStyle(_ style: Style, in range: NSRange) {
        verifyAttributes(in: range) { (attributes, foundRange) in
            XCTAssertNotNil(attributes[.semanticStyle])
            let foundStyle = attributes[.semanticStyle] as? Style
            XCTAssertEqual(foundStyle, style)
            XCTAssertEqual(foundRange, range)
        }
    }

    fileprivate func verifyStyle(_ style: Style) {
        verifyStyle(style, in: fullRange)
    }
}

final class AttributedStringBuilderTests: XCTestCase {

    func testAddOneStyle() {
        // Given
        let string = "Style"
        let builder = AttributedStringBuilder<Style>(string: string)

        // When
        builder.addStyle(.style1)
        let attributedString = builder.build()

        // Then
        attributedString.verifyStyle(.style1)
    }

    func testSetTwoStyles() {
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

    func testSetMultipleStyles() {
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

    func testAddMultipleStylesInAttributedString() {
        // Given
        let string = Style.allCases.map { $0.rawValue }.joined(separator: " ")
        let input = NSAttributedString(string: string, attributes: [.test_foregroundColor: "red"])
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
                let expectedKeys: [NSAttributedString.Key] = [.semanticStyle, .test_foregroundColor]
                    .sorted { $0.rawValue < $1.rawValue }
                XCTAssertEqual(keys, expectedKeys)
            }
        }
    }

    static var allTests = [
        ("testAddOneStyle", testAddOneStyle),
        ("testSetTwoStyles", testSetTwoStyles),
        ("testSetMultipleStyles", testSetMultipleStyles),
        ("testAddMultipleStylesInAttributedString", testAddMultipleStylesInAttributedString),
    ]
}
