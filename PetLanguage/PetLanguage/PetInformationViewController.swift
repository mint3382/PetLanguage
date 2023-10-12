//
//  ViewController.swift
//  PetLanguage
//
//  Created by minsong kim on 10/12/23.
//

import UIKit

class PetInformationViewController: UIViewController {
    let petImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cat1")
        
        return imageView
    }()
    let petName = UITextField(placeholder: "이름을 입력하세요")
    let petAge = UITextField(placeholder: "나이를 입력하세요")
    let petSpecies = UITextField(placeholder: "종을 입력하세요")
    lazy var startButton = UIButton(title: " 대화 시작 ", color: .systemCyan) {
        lazy var uiAction = UIAction() { action in
            guard let name = self.petName.text,
                  let age = self.petAge.text,
                  let species = self.petSpecies.text else {
                return
            }
            
            let nextViewController = ChatViewController(name: name, age: age, species: species)
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        
        return uiAction
    }
    
    let stackView = UIStackView(axis: .vertical)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureStackView()
    }

    func configureStackView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(petImage)
        stackView.addArrangedSubview(petName)
        stackView.addArrangedSubview(petAge)
        stackView.addArrangedSubview(petSpecies)
        stackView.addArrangedSubview(startButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            petImage.heightAnchor.constraint(equalToConstant: 150),
            petImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

}

