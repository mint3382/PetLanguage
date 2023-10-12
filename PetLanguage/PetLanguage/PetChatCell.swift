//
//  PetChatCell.swift
//  PetLanguage
//
//  Created by minsong kim on 10/13/23.
//

import UIKit

class PetChatCell: UITableViewCell {
    static let identifier: String = "PetChatCell"
    
    let chat: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.backgroundColor = .cyan
        textView.layer.cornerRadius = 8
        textView.sizeToFit()
        
        return textView
    }()
    
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
            chat.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            chat.widthAnchor.constraint(lessThanOrEqualToConstant: 200)
        ])
    }
}

