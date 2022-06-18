//
//  TagCell.swift
//  Instagram
//
//  Created by William Tristão de Pauloa on 18/10/21.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    var text: String? {
        didSet {
            guard let text = text else { return }
            textLabel.text = text
        }
    }
    
    lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemBlue.cgColor
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    lazy var deleteButton: UIButton = {
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 20)
        let image = UIImage(systemName: "minus.circle.fill", withConfiguration: iconConfig)
        let btn = UIButton()
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    lazy var stack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [textLabel, deleteButton])
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        contentView.addSubview(container)
        container.addSubview(stack)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: container.topAnchor),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: container.bottomAnchor),
        ])
    }
    
}
