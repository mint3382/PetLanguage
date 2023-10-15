//
//  PetChatCell.swift
//  PetLanguage
//
//  Created by minsong kim on 10/13/23.
//

import UIKit

class PetChatCell: UITableViewCell {
    static let identifier: String = "PetChatCell"
    
    let chatLabel = UILabel(backgroundColor: .systemGray5)
    
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
            chatLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            chatLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

