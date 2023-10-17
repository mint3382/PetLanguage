//
//  UIButton+.swift
//  PetLanguage
//
//  Created by minsong kim on 10/12/23.
//

import UIKit

extension UIButton {
    convenience init(title: String?, color: UIColor) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

