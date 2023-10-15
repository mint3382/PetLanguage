//
//  UILabel+.swift
//  PetLanguage
//
//  Created by minsong kim on 10/15/23.
//

import UIKit

extension UILabel {
    convenience init(backgroundColor: UIColor) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.font = .preferredFont(forTextStyle: .caption2)
        self.numberOfLines = 0
        self.preferredMaxLayoutWidth = 300
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

