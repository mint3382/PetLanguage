//
//  UserChatCell.swift
//  PetLanguage
//
//  Created by minsong kim on 10/13/23.
//

import UIKit

class UserChatCell: UITableViewCell {
    static let identifier: String = "UserChatCell"
    
    let chat = UITextView(backgroundColor: .cyan, isEditable: false)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureChat()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0))
    }
    
    func configureChat() {
        contentView.addSubview(chat)
        
        NSLayoutConstraint.activate([
            chat.topAnchor.constraint(equalTo: contentView.topAnchor),
            chat.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            chat.heightAnchor.constraint(greaterThanOrEqualToConstant: 45),
            chat.widthAnchor.constraint(lessThanOrEqualToConstant: 300)
        ])
    }
}
