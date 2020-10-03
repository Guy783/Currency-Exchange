//
//  UIView+Accessibility.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 20/03/2020.
//

import UIKit

extension UIView {
    func makeViewAccessible(isAccessibilityElement: Bool, accessibilityLabel: String? = nil, accessibilityHint: String?) {
        self.isAccessibilityElement = isAccessibilityElement
        if accessibilityLabel != nil {
            self.accessibilityLabel = accessibilityLabel // Voice Over - succinct label identifying element (use localized string)
        }
        if accessibilityHint != nil {
            self.accessibilityHint = accessibilityHint // Voice Over - brief description of element (use localized string)
        }
    }
}

extension UILabel {
    func makeAccessible(accessibilityLabel: String? = nil,
                        accessibilityHint: String? = nil,
                        prefferedFont: UIFont.TextStyle = .body,
                        adjustsFontForContentSizeCategory: Bool = true) {
        self.font = UIFont.preferredFont(forTextStyle: prefferedFont)
        self.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory
        makeViewAccessible(isAccessibilityElement: self.isAccessibilityElement,
                           accessibilityLabel: accessibilityLabel,
                           accessibilityHint: accessibilityHint)
    }
}

extension UIButton {
    func makeAccessible(accessibilityLabel: String? = nil,
                        accessibilityHint: String? = nil,
                        prefferedFont: UIFont.TextStyle = .body,
                        adjustsFontForContentSizeCategory: Bool = true) {
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: prefferedFont)
        self.titleLabel?.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory
        makeViewAccessible(isAccessibilityElement: self.isAccessibilityElement,
                           accessibilityLabel: accessibilityLabel,
                           accessibilityHint: accessibilityHint)
    }
}

extension UIImageView {
    func makeAccessible(accessibilityLabel: String? = nil,
                        accessibilityHint: String? = nil) {
        makeViewAccessible(isAccessibilityElement: self.isAccessibilityElement,
                           accessibilityLabel: accessibilityLabel,
                           accessibilityHint: accessibilityHint)
    }
}
