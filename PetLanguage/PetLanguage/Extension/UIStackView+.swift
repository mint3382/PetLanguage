//
//  UIStackView+.swift
//  PetLanguage
//
//  Created by minsong kim on 10/12/23.
//

import UIKit

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis) {
        self.init(frame: .zero)
        self.axis = axis
        self.spacing = 8
        self.alignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
