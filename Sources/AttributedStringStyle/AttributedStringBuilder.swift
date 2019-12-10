//
//  AttributedStringBuilder.swift
//  AttributedStringStyle
//
//  Created by Pierre Felgines on 23/11/2018.
//

import Foundation

public class AttributedStringBuilder<Style> {

    private var attributedString: NSMutableAttributedString

    // MARK: - Init

    public init(string: String) {
        self.attributedString = NSMutableAttributedString(string: string)
    }

    public init(attributedString: NSAttributedString) {
        self.attributedString = NSMutableAttributedString(attributedString: attributedString)
    }

    // MARK: - Public

    /**
     Returns the backing attributed string
     */
    public func build() -> NSAttributedString {
        return NSAttributedString(attributedString: attributedString)
    }

    /**
     Adds the given style to all the characters
     - parameter style: Style to apply to the attributed string
     */
    public func addStyle(_ style: Style) {
        addStyle(
            style,
            range: NSRange(location: 0, length: attributedString.length)
        )
    }

    /**
     Adds the given style to the characters in the specified range
     - parameter style: Style to apply to the attributed string
     - parameter range: The range of characters to which the style apply.
     */
    public func addStyle(_ style: Style, range: NSRange) {
        attributedString.addAttributes(
            [.semanticStyle: style],
            range: range
        )
    }

    /**
     Sets the given style to all the characters
     - parameter style: Style to apply to the attributed string
     */
    public func setStyle(_ style: Style) {
        setStyle(
            style,
            range: NSRange(location: 0, length: attributedString.length)
        )
    }

    /**
     Sets the given style to the characters in the specified range
     - parameter style: Style to apply to the attributed string
     - parameter range: The range of characters to which the style apply.
     */
    public func setStyle(_ style: Style, range: NSRange) {
        attributedString.setAttributes(
            [.semanticStyle: style],
            range: range
        )
    }
}
