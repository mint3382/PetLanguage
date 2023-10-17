//
//  UserChatCell.swift
//  PetLanguage
//
//  Created by mint on 10/13/23.
//

import UIKit

final class UserChatCell: UITableViewCell {
    let chatLabel = PaddingLabel(backgroundColor: .cyan)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.backgroundColor = .clear
        configureChat()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureChat() {
        contentView.addSubview(chatLabel)
        
        NSLayoutConstraint.activate([
            chatLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            chatLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            chatLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2)
        ])
    }
}
