//
//  ViewController.swift
//  PetLanguage
//
//  Created by minsong kim on 10/12/23.
//

import UIKit

class PetInformationViewController: UIViewController {
    var pet: Pet?
    
    let logoImage = UIImageView(file: "logo")
    let nameImage = UIImageView(file: "name")
    let ageImage = UIImageView(file: "age")
    let speciesImage = UIImageView(file: "species")
    
    let nameTextField = UITextField(placeholder: "이름")
    let ageTextField = UITextField(placeholder: "나이")
    
    var speciesButton = UIButton(title: "동물 선택", color: .systemBrown)
    var startButton = UIButton()
    
    lazy var catAction = UIAction(title: "냥냥?", handler: { action in
        self.settingPet(type: .cat)
    })
    lazy var dogAction = UIAction(title: "멍멍?", handler: { action in
        self.settingPet(type: .dog)
    })
    lazy var pushNextAction = UIAction() { action in
        guard let pet = self.pet else {
            return
        }
        let nextViewController = ChatViewController(pet: pet)
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    let stackView = UIStackView(axis: .vertical)
    let nameLineStackView = UIStackView(axis: .horizontal)
    let ageLineStackView = UIStackView(axis: .horizontal)
    let speciesLineStackView = UIStackView(axis: .horizontal)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        nameTextField.delegate = self
        ageTextField.delegate = self
        settingButtons()
        configureLineStackViews()
        configureStackView()
    }
    
    func settingButtons() {
        speciesButton.menu = UIMenu(title: "멍냥멍냥??", identifier: nil, options: .singleSelection, children: [self.catAction, self.dogAction])
        startButton.addAction(pushNextAction, for: .touchUpInside)
        startButton.setImage(UIImage(named: "start"), for: .normal)
        speciesButton.showsMenuAsPrimaryAction = true
        startButton.showsMenuAsPrimaryAction = true
    }
    
    func settingPet(type: PetType) {
        guard let name = self.nameTextField.text,
              let age = self.ageTextField.text else {
            return
        }
        
        self.pet = Pet(name: name, age: Int(age) ?? 100, species: type)
        self.logoImage.image = UIImage(named: type.randomImage())
    }
    
    func configureLineStackViews() {
        nameLineStackView.addArrangedSubview(nameImage)
        nameLineStackView.addArrangedSubview(nameTextField)
        
        ageLineStackView.addArrangedSubview(ageImage)
        ageLineStackView.addArrangedSubview(ageTextField)
        
        speciesLineStackView.addArrangedSubview(speciesImage)
        speciesLineStackView.addArrangedSubview(speciesButton)
        
        NSLayoutConstraint.activate([
            nameLineStackView.heightAnchor.constraint(equalToConstant: 50),
            ageLineStackView.heightAnchor.constraint(equalToConstant: 40),
            speciesLineStackView.heightAnchor.constraint(equalToConstant: 50),
            nameImage.widthAnchor.constraint(equalToConstant: 100),
            ageImage.widthAnchor.constraint(equalToConstant: 100),
            speciesImage.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    func configureStackView() {
        view.addSubview(stackView)
        stackView.alignment = .fill
        
        stackView.addArrangedSubview(logoImage)
        stackView.addArrangedSubview(nameLineStackView)
        stackView.addArrangedSubview(ageLineStackView)
        stackView.addArrangedSubview(speciesLineStackView)
        stackView.addArrangedSubview(startButton)
        
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logoImage.heightAnchor.constraint(equalToConstant: 270),
            logoImage.widthAnchor.constraint(equalToConstant: 270),
            startButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}

extension PetInformationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            ageTextField.becomeFirstResponder()
        } else {
            ageTextField.resignFirstResponder()
        }
    }
}

