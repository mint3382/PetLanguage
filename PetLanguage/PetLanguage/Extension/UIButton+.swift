//
//  UIButton+.swift
//  PetLanguage
//
//  Created by minsong kim on 10/12/23.
//

import UIKit

extension UIButton {
    convenience init(title: String?, color: UIColor, action: (() -> UIAction)) {
        self.init(frame: .zero)
        self.init(primaryAction: action())
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(action: (() -> UIAction)) {
        self.init(frame: .zero)
        self.init(primaryAction: action())
        self.setImage(UIImage(systemName: "paperplane"), for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

