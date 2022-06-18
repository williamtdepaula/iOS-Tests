//
//  ChatViewController.swift
//  Instagram
//
//  Created by William Tristão de Pauloa on 21/10/21.
//

import UIKit

class ChatViewController: UIViewController {
    let cellChat = "chat"
   
    var messages = [Message(message: "Olá", fromLocal: false), Message(message: "Olá", fromLocal: true)]
    
    private var containerInputConstraint: NSLayoutConstraint?
    private let initialContainerInputHeight: CGFloat = 60
    
    lazy var messagesTableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(MessageCell.self, forCellReuseIdentifier: cellChat)
        view.transform = CGAffineTransform(scaleX: 1, y: -1)
        return view
    }()
    
    lazy var containerTextInput: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        return view
    }()
    
    lazy var messageInput: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.font = UIFont.systemFont(ofSize: 20)
        view.isScrollEnabled = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemBlue.cgColor
        return view
    }()
    
    lazy var sendMessageButton: UIButton = {
       let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 30)
        view.setImage(UIImage(systemName: "paperplane.circle.fill", withConfiguration: iconConfig), for: .normal)
        view.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return view
    }()
    
    @objc private func sendMessage(){
        guard let message = messageInput.text else {return}
        messages.append(Message(message: message, fromLocal: true))
        messagesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private  func setupViews(){
        view.backgroundColor = .systemBackground
        view.addSubview(messagesTableView)
        view.addSubview(containerTextInput)
                
        containerTextInput.addSubview(messageInput)
        containerTextInput.addSubview(sendMessageButton)
    }
    
    private func setupConstraints(){
        var constraints: [NSLayoutConstraint] = [
            messagesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            messagesTableView.bottomAnchor.constraint(equalTo: containerTextInput.topAnchor, constant: -10),
            messagesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            messagesTableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1)
        ]
        
        constraints.append(contentsOf: [
            containerTextInput.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            containerTextInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerTextInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerTextInput.heightAnchor.constraint(equalTo: messageInput.heightAnchor, constant: 20)
        ])
        
        constraints.append(contentsOf: [
            messageInput.bottomAnchor.constraint(equalTo: containerTextInput.bottomAnchor, constant: -10),
            messageInput.leadingAnchor.constraint(equalTo: containerTextInput.leadingAnchor, constant: 10),
            messageInput.widthAnchor.constraint(equalTo: containerTextInput.widthAnchor, multiplier: 0.85),
            messageInput.heightAnchor.constraint(lessThanOrEqualToConstant: 150)
        ])
        
        constraints.append(contentsOf: [
            sendMessageButton.centerYAnchor.constraint(equalTo: containerTextInput.centerYAnchor),
            sendMessageButton.trailingAnchor.constraint(equalTo: containerTextInput.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellChat, for: indexPath) as! MessageCell
        let currentMessage = messages[(messages.count-1) - indexPath.row]
        cell.message = currentMessage.message
        cell.fromLocal = currentMessage.fromLocal
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        cell.selectionStyle = .none
        
        return cell
    }
        
}
