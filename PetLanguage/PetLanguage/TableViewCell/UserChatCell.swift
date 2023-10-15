//
//  UserChatCell.swift
//  PetLanguage
//
//  Created by minsong kim on 10/13/23.
//

import UIKit

class UserChatCell: UITableViewCell {
    static let identifier: String = "UserChatCell"

    let chatLabel = UILabel(backgroundColor: .cyan)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureChat()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureChat() {
        contentView.addSubview(chatLabel)
        
        NSLayoutConstraint.activate([
            chatLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            chatLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            chatLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
