//
//  PetChatCell.swift
//  PetLanguage
//
//  Created by mint on 10/13/23.
//

import UIKit

final class PetChatCell: UITableViewCell {
    let chatLabel = PaddingLabel(backgroundColor: .systemGray5)
    
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
            chatLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            chatLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2)
        ])
    }
}

