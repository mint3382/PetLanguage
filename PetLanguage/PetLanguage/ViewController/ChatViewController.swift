//
//  ChatViewController.swift
//  PetLanguage
//
//  Created by mint on 10/12/23.
//

import UIKit

final class ChatViewController: UIViewController {
    private let pet: Pet
    private var chats: [Chat] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.scrollToBottom()
            }
        }
    }
    
    private let lineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let userInputTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        return textView
    }()
    private var sendButton = UIButton()
    private lazy var sendAction = UIAction() { [weak self] action in
        let userChat = Chat(sender: .user, message: self?.userInputTextView.text)
        self?.chats.append(userChat)
        self?.userInputTextView.text = ""
        self?.receiveChatGPTResponse()
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
        view.layer.contents = UIImage(named: "paws")?.cgImage
        settingButton()
        settingTableView()
        configureUI()
    }
    
    private func settingButton() {
        sendButton.addAction(sendAction, for: .touchUpInside)
        sendButton.setImage(UIImage(named: "paw"), for: .normal)
    }
    
    private func settingTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .interactive
        tableView.register(UserChatCell.self, forCellReuseIdentifier: "UserChatCell")
        tableView.register(PetChatCell.self, forCellReuseIdentifier: "PetChatCell")
    }
    
    private func configureUI() {
        navigationItem.title = pet.name
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(lineStackView)
        configureTableView()
        configureChatLine()
    }
    
    private func configureTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: lineStackView.topAnchor)
        ])
    }
    
    private func configureChatLine() {
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
    
    private func scrollToBottom() {
        let indexPath = IndexPath(row: chats.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

extension ChatViewController: ErrorAlertPresentable {
    private func receiveChatGPTResponse() {
        let settings: [PetSetting] = [PetSetting(role: .system, message: pet.makePrompt()), PetSetting(role: .user, message: chats.last?.message ?? "")]
        
        let networkManager = GPTNetworkService()
        networkManager.fetchChatGPTData(chats: settings) { [weak self] result in
            switch result {
            case .success(let data):
                let petChat = Chat(sender: .pet, message: data.choices[0].message.content)
                self?.chats.append(petChat)
            case .failure(let error):
                self?.presentErrorCheckAlert(error: error)
            }
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: index를 subscript 사용하여 안전하게
        switch chats[indexPath.row].sender {
        case .user:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserChatCell.self), for: indexPath) as? UserChatCell else {
                return UITableViewCell()
            }
            cell.chatLabel.text = chats[indexPath.row].message
            return cell
        case .pet:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PetChatCell.self), for: indexPath) as? PetChatCell else {
                return UITableViewCell()
            }
            cell.chatLabel.text = chats[indexPath.row].message
            return cell
        }
    }
}
