//
//  NSAttributedString+Style.swift
//  AttributedStringStyle
//
//  Created by Pierre Felgines on 23/11/2018.
//

import Foundation

public extension NSAttributedString {

    func styled<T>(with styler: AttributedStringStyler<T>) -> NSAttributedString {
        return styler.attributedString(from: self)
    }
}
