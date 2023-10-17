//
//  ErrorAlertPresentable.swift
//  PetLanguage
//
//  Created by mint on 10/17/23.
//

import UIKit

protocol ErrorAlertPresentable where Self: UIViewController { }

extension ErrorAlertPresentable {
    var closeAction: UIAlertAction {
        let action = UIAlertAction(title: String(localized: "Close"), style: .cancel)
        
        return action
    }
    
    func presentErrorCheckAlert(error: Error) {
        let alert = UIAlertController(title: "ERROR!", message: error.localizedDescription, preferredStyle: .alert)
        
        alert.addAction(closeAction)
        
        self.present(alert, animated: true)
    }
}
