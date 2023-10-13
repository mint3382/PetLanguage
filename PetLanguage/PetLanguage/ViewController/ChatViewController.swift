//
//  ChatViewController.swift
//  PetLanguage
//
//  Created by minsong kim on 10/12/23.
//

import UIKit

class ChatViewController: UIViewController {
    let pet: Pet
    var chats: [Chat] = []
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    let userInputTextView = UITextView(backgroundColor: .systemBackground, isScrollEnabled: true, isEditable: true, borderColor: UIColor.darkGray.cgColor)
    
    lazy var sendButton = UIButton {
        lazy var action = UIAction() { action in
            let userChat = Chat(sender: .user, message: self.userInputTextView.text)
            self.chats.append(userChat)
            self.userInputTextView.text = ""
            self.tableView.reloadData()
            //self.updateChat(count: self.chats.count)
        }
        
        return action
    }
    let lineStackView = UIStackView(axis: .horizontal)
    
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
        tableView.rowHeight = UITableView.automaticDimension
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
            lineStackView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            lineStackView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 8),
            lineStackView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -8),
            lineStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            userInputTextView.widthAnchor.constraint(lessThanOrEqualTo: lineStackView.widthAnchor, multiplier: 0.9),
            userInputTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 45)
        ])
    }
    
    // 서버에게 데이터 받기
    
    
    
//    func updateChat(count: Int) {
//        let indexPath = IndexPath(row: count - 1, section: 0)
//        
//        self.tableView.beginUpdates()
//        self.tableView.insertRows(at: [indexPath], with: .none)
//        self.tableView.endUpdates()
//        
//        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
//    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if chats[indexPath.row].sender == .user {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserChatCell.identifier, for: indexPath) as! UserChatCell
            cell.chat.text = chats[indexPath.row].message
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PetChatCell.identifier, for: indexPath) as! PetChatCell
            cell.chat.text = chats[indexPath.row].message
            return cell
        }
    }
}
