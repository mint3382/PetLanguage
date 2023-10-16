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
    let lineStackView = UIStackView(axis: .horizontal)
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    let userInputTextView = UITextView(borderColor: UIColor.darkGray.cgColor)
    var sendButton = UIButton()
    
    lazy var sendAction = UIAction() { action in
        let userChat = Chat(sender: .user, message: self.userInputTextView.text)
        self.chats.append(userChat)
        self.userInputTextView.text = ""
        self.makeRequest()
    }
    
    func settingButton() {
        sendButton.addAction(sendAction, for: .touchUpInside)
        sendButton.setImage(UIImage(named: "paw"), for: .normal)
    }
    
    init(pet: Pet) {
        self.pet = pet
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingButton()
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
        view.addSubview(tableView)
        view.addSubview(lineStackView)
        configureTableView()
        configureChatLine()
    }
    
    func configureTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: lineStackView.topAnchor)
        ])
    }
    
    func configureChatLine() {
        lineStackView.addArrangedSubview(userInputTextView)
        lineStackView.addArrangedSubview(sendButton)
 
        NSLayoutConstraint.activate([
            lineStackView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
            lineStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            lineStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            userInputTextView.heightAnchor.constraint(greaterThanOrEqualTo: sendButton.heightAnchor, multiplier: 1.2),
            sendButton.widthAnchor.constraint(equalToConstant: 30),
            sendButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // 서버에게 데이터 받기
    func makeRequest() {
        let settings: [PetSetting] = [PetSetting(role: .system, message: pet.makePrompt()), PetSetting(role: .user, message: chats.last?.message ?? "")]
        
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
