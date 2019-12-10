//
//  TestUtils.swift
//  AttributedStringStyle
//
//  Created by Pierre Felgines on 10/12/2019.
//

import Foundation
import XCTest

extension NSAttributedString.Key {
    static let test_foregroundColor = NSAttributedString.Key(rawValue: "test_foregroundColor")
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

    var fullRange: NSRange {
        return NSRange(location: 0, length: self.length)
    }
}
