//
//  ViewController.swift
//  PetLanguage
//
//  Created by mint on 10/12/23.
//

import UIKit

final class PetInformationViewController: UIViewController {
    private var pet: Pet?
    private var age: Int = 0
    private let ageList: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    
    private let mainImage = UIImageView(file: "logo")
    private let nameImage = UIImageView(file: "name")
    private let ageImage = UIImageView(file: "age")
    private let speciesImage = UIImageView(file: "species")
    private let nameTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "이름"
        text.borderStyle = .roundedRect
        return text
    }()
    private let agePickerView = UIPickerView()
    private lazy var speciesSegmentControl = UISegmentedControl(items: [catAction, dogAction])
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "start"), for: .normal)
        button.addAction(pushNextAction, for: .touchUpInside)
        return button
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let nameLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    private let ageLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        return stackView
    }()
    private let speciesLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    private lazy var catAction = UIAction(title: "냥냥?", handler: { [weak self] action in
        self?.settingMainImage(type: .cat)
    })
    private lazy var dogAction = UIAction(title: "멍멍?", handler: { [weak self] action in
        self?.settingMainImage(type: .dog)
    })
    private lazy var pushNextAction = UIAction() { [weak self] action in
        var pet: Pet
        guard let name = self?.nameTextField.text else {
            return
        }
        
        if self?.speciesSegmentControl.selectedSegmentIndex == 0 {
            //TODO: age 이유 있는 100
            pet = Pet(name: name, age: self?.age ?? 100, species: .cat)
        } else {
            pet = Pet(name: name, age: self?.age ?? 100, species: .dog)
        }
        
        let nextViewController = ChatViewController(pet: pet)
        
        self?.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        nameTextField.delegate = self
        agePickerView.delegate = self
        agePickerView.dataSource = self
        configureUI()
    }

    private func settingMainImage(type: PetType) {
        self.mainImage.image = UIImage(named: type.randomImage())
    }
    
    private func configureUI() {
        view.addSubview(stackView)
        configureStackView()
        configureLineStackViews()
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
        stackView.addArrangedSubview(mainImage)
        stackView.addArrangedSubview(nameLineStackView)
        stackView.addArrangedSubview(ageLineStackView)
        stackView.addArrangedSubview(speciesLineStackView)
        stackView.addArrangedSubview(startButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
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
        //TODO: index subscript 통해 안전하게 만들것
        age = Int(ageList[row]) ?? 100
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ageList[row]
    }
}
