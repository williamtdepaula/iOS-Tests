//
//  MessageCellTableViewCell.swift
//  Instagram
//
//  Created by William Tristão de Pauloa on 21/10/21.
//

import UIKit

class MessageCell: UITableViewCell {
    
    var cardLeadingAnchor: NSLayoutConstraint?
    var cardTrailingAnchor: NSLayoutConstraint?
    
    var message: String? {
        didSet {
            guard let message = message else {return}
            
            messageLabel.text = message
        }
    }
    
    var fromLocal: Bool? {
        didSet {
            configAlignment()
            configColor()
        }
    }
    
    lazy var cardMessage: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemTeal
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    lazy var messageLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 20)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        self.addSubview(cardMessage)
        cardMessage.addSubview(messageLabel)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            cardMessage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cardMessage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cardMessage.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: cardMessage.topAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: cardMessage.leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: cardMessage.trailingAnchor, constant: -10),
            messageLabel.bottomAnchor.constraint(equalTo: cardMessage.bottomAnchor, constant: -10),
        ])
    }
    
    private func configAlignment(){
        if fromLocal != nil, fromLocal == true {
            cardTrailingAnchor = cardMessage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
            cardTrailingAnchor?.isActive = true
            cardLeadingAnchor?.isActive = false
        } else {
            cardLeadingAnchor = cardMessage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
            cardLeadingAnchor?.isActive = true
            cardTrailingAnchor?.isActive = false
        }
    }
    
    private func configColor(){
        if fromLocal != nil, fromLocal == true {
            cardMessage.backgroundColor = .systemMint
        }else {
            cardMessage.backgroundColor = .systemCyan
        }
    }
}
