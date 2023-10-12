//
//  UITextField+.swift
//  PetLanguage
//
//  Created by minsong kim on 10/12/23.
//

import UIKit

extension UITextField {
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
