//
//  ViewController.swift
//  PetLanguage
//
//  Created by minsong kim on 10/12/23.
//

import UIKit

final class PetInformationViewController: UIViewController {
    private var pet: Pet?
    private var age: Int = 0
    
    private let mainImage = UIImageView(file: "logo")
    private let nameImage = UIImageView(file: "name")
    private let ageImage = UIImageView(file: "age")
    private let speciesImage = UIImageView(file: "species")
    
    private let nameTextField = UITextField(placeholder: "이름")
    private var startButton = UIButton()
    
    private lazy var speciesSegmentControl = UISegmentedControl(items: [catAction, dogAction])
    private lazy var catAction = UIAction(title: "냥냥?", handler: { action in
        self.settingMainImage(type: .cat)
    })
    private lazy var dogAction = UIAction(title: "멍멍?", handler: { action in
        self.settingMainImage(type: .dog)
    })
    private lazy var pushNextAction = UIAction() { action in
        var pet: Pet
        
        if self.speciesSegmentControl.selectedSegmentIndex == 0 {
            pet = self.settingPet(type: .cat)
        } else {
            pet = self.settingPet(type: .dog)
        }
        
        let nextViewController = ChatViewController(pet: pet)
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    private let stackView = UIStackView(axis: .vertical)
    private let nameLineStackView = UIStackView(axis: .horizontal)
    private let ageLineStackView = UIStackView(axis: .horizontal)
    private let speciesLineStackView = UIStackView(axis: .horizontal)
    
    private let ageList: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    private let agePickerView = UIPickerView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        nameTextField.delegate = self
        agePickerView.delegate = self
        agePickerView.dataSource = self
        settingButtons()
        configureStackView()
        configureLineStackViews()
    }
    
    private func settingButtons() {
        startButton.addAction(pushNextAction, for: .touchUpInside)
        startButton.setImage(UIImage(named: "start"), for: .normal)
        startButton.showsMenuAsPrimaryAction = true
    }
    
    private func settingMainImage(type: PetType) {
        self.mainImage.image = UIImage(named: type.randomImage())
    }
    
    private func settingPet(type: PetType) -> Pet {
        guard let name = self.nameTextField.text else {
            return Pet(name: "secret", age: age, species: type)
        }
        
        return Pet(name: name, age: age, species: type)
    }
    
    private func configureLineStackViews() {
        nameLineStackView.addArrangedSubview(nameImage)
        nameLineStackView.addArrangedSubview(nameTextField)
        
        ageLineStackView.addArrangedSubview(ageImage)
        ageLineStackView.addArrangedSubview(agePickerView)
        
        speciesLineStackView.addArrangedSubview(speciesImage)
        speciesLineStackView.addArrangedSubview(speciesSegmentControl)
        
        NSLayoutConstraint.activate([
            nameLineStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            ageLineStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            speciesLineStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            nameImage.widthAnchor.constraint(equalToConstant: 90),
            ageImage.widthAnchor.constraint(equalToConstant: 90),
            speciesImage.widthAnchor.constraint(equalToConstant: 90)
        ])
    }

    private func configureStackView() {
        view.addSubview(stackView)
        stackView.alignment = .fill
        
        stackView.addArrangedSubview(mainImage)
        stackView.addArrangedSubview(nameLineStackView)
        stackView.addArrangedSubview(ageLineStackView)
        stackView.addArrangedSubview(speciesLineStackView)
        stackView.addArrangedSubview(startButton)
        
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            mainImage.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            startButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
    }
}

extension PetInformationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            nameTextField.resignFirstResponder()
        }
        return false
    }
}

extension PetInformationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ageList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        age = Int(ageList[row]) ?? 100
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ageList[row]
    }
}
