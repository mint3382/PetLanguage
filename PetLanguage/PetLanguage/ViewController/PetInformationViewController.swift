//
//  ViewController.swift
//  PetLanguage
//
//  Created by minsong kim on 10/12/23.
//

import UIKit

class PetInformationViewController: UIViewController {
    var pet: Pet?
    var age: Int = 0
    
    let mainImage = UIImageView(file: "logo")
    let nameImage = UIImageView(file: "name")
    let ageImage = UIImageView(file: "age")
    let speciesImage = UIImageView(file: "species")
    
    let nameTextField = UITextField(placeholder: "이름")
    var startButton = UIButton()
    
    lazy var speciesSegmentControl = UISegmentedControl(items: [catAction, dogAction])
    lazy var catAction = UIAction(title: "냥냥?", handler: { action in
        self.settingMainImage(type: .cat)
    })
    lazy var dogAction = UIAction(title: "멍멍?", handler: { action in
        self.settingMainImage(type: .dog)
    })
    lazy var pushNextAction = UIAction() { action in
        var pet: Pet
        
        if self.speciesSegmentControl.selectedSegmentIndex == 0 {
            pet = self.settingPet(type: .cat)
        } else {
            pet = self.settingPet(type: .dog)
        }
        
        let nextViewController = ChatViewController(pet: pet)
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    let stackView = UIStackView(axis: .vertical)
    let nameLineStackView = UIStackView(axis: .horizontal)
    let ageLineStackView = UIStackView(axis: .horizontal)
    let speciesLineStackView = UIStackView(axis: .horizontal)
    
    let ageList: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    let agePickerView = UIPickerView()

    
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
    
    func settingButtons() {
        startButton.addAction(pushNextAction, for: .touchUpInside)
        startButton.setImage(UIImage(named: "start"), for: .normal)
        startButton.showsMenuAsPrimaryAction = true
    }
    
    func settingMainImage(type: PetType) {
        self.mainImage.image = UIImage(named: type.randomImage())
    }
    
    func settingPet(type: PetType) -> Pet {
        guard let name = self.nameTextField.text else {
            return Pet(name: "secret", age: age, species: type)
        }
        
        return Pet(name: name, age: age, species: type)
    }
    
    func configureLineStackViews() {
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

    func configureStackView() {
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
