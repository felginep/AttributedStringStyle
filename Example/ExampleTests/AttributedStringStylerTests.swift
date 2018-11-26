//
//  AttributedStringStylerTests.swift
//  AttributedStringStyleTests
//
//  Created by Pierre Felgines on 26/11/2018.
//

import Foundation
import Quick
import Nimble
import AttributedStringStyle

private enum Style: String, CaseIterable {
    case red
    case green
    case blue

    var color: UIColor {
        switch self {
        case .red:
            return .red
        case .green:
            return .green
        case .blue:
            return .blue
        }
    }
}

extension NSAttributedString {

    fileprivate func verifyColor(_ color: UIColor, in range: NSRange) {
        verifyAttributes(in: range) { (attributes, foundRange) in
            expect(attributes[.foregroundColor]).toNot(beNil())
            let foundColor = attributes[.foregroundColor] as? UIColor
            expect(foundColor).to(equal(color))
            expect(foundRange).to(equal(range))
        }
    }

    fileprivate func verifyColor(_ color: UIColor) {
        verifyColor(color, in: fullRange)
    }
}

class AttributedStringStylerTests: QuickSpec {

    override func spec() {

        var styler: AttributedStringStyler<Style>!

        beforeEach {
            styler = AttributedStringStyler<Style>()
            Style.allCases.forEach {
                styler.register(attributes: [.foregroundColor: $0.color], forStyle: $0)
            }
        }

        it("should replace one style") {
            // Given
            let builder = AttributedStringBuilder<Style>(string: "Red")
            builder.setStyle(.red)
            let input = builder.build()

            // When
            let result = input.styled(with: styler)

            // Then
            result.verifyColor(.red)
        }

        it("should replace multiple colors") {
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
    }
}
