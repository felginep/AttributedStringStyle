//
//  AttributedStringStyler.swift
//  TrainingJonathan
//
//  Created by Pierre Felgines on 23/11/2018.
//

import Foundation

public class AttributedStringStyler<Style: Hashable> {

    public typealias Attributes = [NSAttributedString.Key: Any]

    private var styleToAttributes: [Style: Attributes] = [:]

    public init() {}

    // MARK: - Public

    /**
     Register attributes for a style
     - parameter attributes: A dictionary containing the attributes to add.
     - parameter style: A style for which attributes are registered
     */
    public func register(attributes: Attributes, forStyle style: Style) {
        styleToAttributes[style] = attributes
    }

    /**
     Create a new attributed string where all style occurrences are replaced with registered attributes
     - parameter input: The input attribtued string
     - returns: A newly created attributed string with attributes and no more style occurrences
     */
    public func attributedString(from input: NSAttributedString) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: input)
        attributedString.enumerateAttributes(
            in: NSRange(location: 0, length: attributedString.length),
            options: NSAttributedString.EnumerationOptions(rawValue: 0)
        ) { (attributes, range, _) in
            guard let value = attributes[.semanticStyle] as? Style else {
                return
            }
            attributedString.removeAttribute(.semanticStyle, range: range)
            attributedString.addAttributes(styleToAttributes[value] ?? [:], range: range)
        }
        return (attributedString.copy() as? NSAttributedString) ?? input
    }
}
