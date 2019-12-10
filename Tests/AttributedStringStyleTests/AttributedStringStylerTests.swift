//
//  AttributedStringStylerTests.swift
//  AttributedStringStyleTests
//
//  Created by Pierre Felgines on 26/11/2018.
//

import Foundation
import AttributedStringStyle
import XCTest

private enum Style: String, CaseIterable {
    case red
    case green
    case blue

    // (Pierre Felgines) 10/12/2019 Do not use UIColor here because we can't import UIKit in SPM tests
    var color: String {
        switch self {
        case .red:
            return "red"
        case .green:
            return "green"
        case .blue:
            return "blue"
        }
    }
}

extension NSAttributedString {

    fileprivate func verifyColor(_ color: String, in range: NSRange) {
        verifyAttributes(in: range) { (attributes, foundRange) in
            XCTAssertNotNil(attributes[.test_foregroundColor])
            let foundColor = attributes[.test_foregroundColor] as? String
            XCTAssertEqual(foundColor, color)
            XCTAssertEqual(foundRange, range)
        }
    }

    fileprivate func verifyColor(_ color: String) {
        verifyColor(color, in: fullRange)
    }
}

final class AttributedStringStylerTests: XCTestCase {

    private var styler: AttributedStringStyler<Style>!

    override func setUp() {
        super.setUp()
        styler = AttributedStringStyler<Style>()
        Style.allCases.forEach {
            styler.register(attributes: [.test_foregroundColor: $0.color], forStyle: $0)
        }
    }

    func testReplaceOneStyle() {
        // Given
        let builder = AttributedStringBuilder<Style>(string: "Red")
        builder.setStyle(.red)
        let input = builder.build()

        // When
        let result = input.styled(with: styler)

        // Then
        result.verifyColor("red")
    }

    func testReplaceMultipleColors() {
        // Given
        let string = Style.allCases.map { $0.rawValue }.joined(separator: " ")
        let builder = AttributedStringBuilder<Style>(string: string)
        for style in Style.allCases {
            let styleRange = NSString(string: string).range(of: style.rawValue)
            builder.setStyle(style, range: styleRange)
        }
        let input = builder.build()

        // When
        let result = input.styled(with: styler)

        // Then
        for style in Style.allCases {
            let styleRange = NSString(string: string).range(of: style.rawValue)
            result.verifyColor(style.color, in: styleRange)
        }
    }

    static var allTests = [
        ("testReplaceOneStyle", testReplaceOneStyle),
        ("testReplaceMultipleColors", testReplaceMultipleColors)
    ]
}
