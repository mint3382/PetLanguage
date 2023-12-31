//
//  UIImageView+.swift
//  PetLanguage
//
//  Created by mint on 10/16/23.
//

import UIKit

extension UIImageView {
    convenience init(file: String) {
        self.init(frame: .zero)
        self.image = UIImage(named: file)
    }
}
