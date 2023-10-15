//
//  ViewController.swift
//  PetLanguage
//
//  Created by minsong kim on 10/12/23.
//

import UIKit

class PetInformationViewController: UIViewController {
    let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        
        return imageView
    }()
    let petName = UITextField(placeholder: "이름")
    let petAge = UITextField(placeholder: "나이")
    lazy var catButton = UIButton(title: " 고양이 ", color: .systemGreen) {
        lazy var uiAction = UIAction() { action in
            guard let name = self.petName.text,
                  let age = self.petAge.text else {
                return
            }
            
            let pet = Pet(name: name, age: Int(age) ?? 100, species: .cat)
            
            let nextViewController = ChatViewController(pet: pet)
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        
        return uiAction
    }
    
    lazy var dogButton = UIButton(title: " 강아지 ", color: .orange) {
        lazy var uiAction = UIAction() { action in
            guard let name = self.petName.text,
                  let age = self.petAge.text else {
                return
            }
            
            let pet = Pet(name: name, age: Int(age) ?? 1, species: .dog)
            
            let nextViewController = ChatViewController(pet: pet)
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        
        return uiAction
    }
    
    let stackView = UIStackView(axis: .vertical)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureStackView()
        petName.delegate = self
        petAge.delegate = self
    }

    func configureStackView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(logoImage)
        stackView.addArrangedSubview(petName)
        stackView.addArrangedSubview(petAge)
        stackView.addArrangedSubview(catButton)
        stackView.addArrangedSubview(dogButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logoImage.heightAnchor.constraint(equalToConstant: 400),
            logoImage.widthAnchor.constraint(equalToConstant: 400)
        ])
    }
}

extension PetInformationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == petName {
            petAge.becomeFirstResponder()
        } else {
            petAge.resignFirstResponder()
        }
    }
}

