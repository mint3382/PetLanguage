//
//  PetChatCell.swift
//  PetLanguage
//
//  Created by minsong kim on 10/13/23.
//

import UIKit

class PetChatCell: UITableViewCell {
    static let identifier: String = "PetChatCell"
    
    let chat = UITextView(backgroundColor: .systemGray5, isEditable: false)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureChat()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureChat() {
        contentView.addSubview(chat)
        
        NSLayoutConstraint.activate([
            chat.topAnchor.constraint(equalTo: contentView.topAnchor),
            chat.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            chat.heightAnchor.constraint(greaterThanOrEqualToConstant: 45),
            chat.widthAnchor.constraint(lessThanOrEqualToConstant: 200)
        ])
    }
}

