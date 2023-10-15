//
//  ChatViewController.swift
//  PetLanguage
//
//  Created by minsong kim on 10/12/23.
//

import UIKit

class ChatViewController: UIViewController {
    let pet: Pet
    var chats: [Chat] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    let userInputTextView = UITextView(borderColor: UIColor.darkGray.cgColor)
    
    lazy var sendButton = UIButton {
        lazy var action = UIAction() { action in
            let userChat = Chat(sender: .user, message: self.userInputTextView.text)
            self.chats.append(userChat)
            self.userInputTextView.text = ""
            self.makeRequest()
        }
        
        return action
    }
    
    let lineStackView = UIStackView(axis: .horizontal)
    let fullStackView = UIStackView(axis: .vertical)
    
    init(pet: Pet) {
        self.pet = pet
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView()
        configureUI()
    }
    
    func settingTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserChatCell.self, forCellReuseIdentifier: "UserChatCell")
        tableView.register(PetChatCell.self, forCellReuseIdentifier: "PetChatCell")
    }
    
    func configureUI() {
        navigationItem.title = pet.name
        view.backgroundColor = .systemBackground
        configureTableView()
        configureChatLine()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    func configureChatLine() {
        view.addSubview(lineStackView)
        lineStackView.addArrangedSubview(userInputTextView)
        lineStackView.addArrangedSubview(sendButton)
        
        NSLayoutConstraint.activate([
            //lineStackView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            lineStackView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 8),
            lineStackView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -8),
            lineStackView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.bottomAnchor),
            userInputTextView.widthAnchor.constraint(lessThanOrEqualTo: lineStackView.widthAnchor, multiplier: 0.9),
            userInputTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 45)
        ])
    }
    
    // 서버에게 데이터 받기
    func makeRequest() {
        let settings: [PetSetting] = [PetSetting(role: .system, message: "너는 \(pet.name)라는 이름을 가진 \(pet.age)살의 \(pet.species)이다."), PetSetting(role: .user, message: chats.last?.message ?? "")]
        
        let networkManager = Network()
        let request = networkManager.makeURLRequest(chats: settings)
        let _: () = networkManager.performRequest(request: request) { result in
            switch result {
            case .success(let data):
                let petChat = Chat(sender: .pet, message: data.choices[0].message.content)
                self.chats.append(petChat)
            case .failure(let error):
                print(error)
            }
        }
    }
//
//        Task {
//            do {
//                let answer = try await Network.fetchChat(chats: settings)
//                let petChat = Chat(sender: .pet, message: answer.choices[0].message.content)
//                self.chats.append(petChat)
//                self.tableView.reloadData()
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
    
//    func setUpNotification() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
    
//    @objc func keyboardWillShow(_ notification: Notification) {
//        guard let userInfo = notification.userInfo as NSDictionary?,
//              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
//            return
//        }
//        let keyboardRectangle = keyboardFrame.cgRectValue
//       
//        if (userInputTextView.inputViewController?.isEditing == true) {
//            keyboardAnimate(keyboardRectangle: keyboardRectangle)
//        }
//    }
    
//    func keyboardAnimate(keyboardRectangle: CGRect) {
//        if keyboardRectangle.height > (self.view.frame.height - userInputTextView.frame.maxY) {
//            self.view.transform = CGAffineTransform(translationX: 0, y: (self.view.frame.height - keyboardRectangle.height - userInputTextView.frame.maxY))
//        }
//    }
    
//    @objc func keyboardWillHide(notification: Notification) {
//        self.view.transform = .identity
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if chats[indexPath.row].sender == .user {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserChatCell.identifier, for: indexPath) as! UserChatCell
            cell.chatLabel.text = chats[indexPath.row].message
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PetChatCell.identifier, for: indexPath) as! PetChatCell
            cell.chatLabel.text = chats[indexPath.row].message
            return cell
        }
    }
}
