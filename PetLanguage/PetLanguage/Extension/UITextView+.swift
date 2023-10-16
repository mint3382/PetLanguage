//
//  UITextView+.swift
//  PetLanguage
//
//  Created by minsong kim on 10/13/23.
//

import UIKit

extension UITextView {
    convenience init(borderColor: CGColor) {
        self.init(frame: .zero)
        self.layer.borderColor = borderColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.textContainer.maximumNumberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
