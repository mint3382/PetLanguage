//
//  UITextView+.swift
//  PetLanguage
//
//  Created by minsong kim on 10/13/23.
//

import UIKit

extension UITextView {
    convenience init(backgroundColor: UIColor, isScrollEnabled: Bool = false ,isEditable: Bool = false, borderColor: CGColor = UIColor.systemBackground.cgColor) {
        self.init(frame: .zero)
        self.isScrollEnabled = isScrollEnabled
        self.isEditable = isEditable
        self.backgroundColor = backgroundColor
        self.layer.borderColor = borderColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.textContainer.maximumNumberOfLines = 0
        self.sizeToFit()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
