//
//  PageCell.swift
//  Instagram
//
//  Created by William Tristão de Pauloa on 18/10/21.
//

import UIKit

class PageCell: UICollectionViewCell {
    var page: Page? {
        didSet {
            guard let pageUnwrapped = page else { return }
            
            logo.image = UIImage(named: pageUnwrapped.imageName )
            titleText.text = pageUnwrapped.title
            
            let attributedText = NSMutableAttributedString(
                string: pageUnwrapped.title,
                attributes:[NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)]
            )
            
            attributedText.append(NSMutableAttributedString(
                string: pageUnwrapped.description,
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            ))
            
            titleText.attributedText = attributedText
            titleText.textAlignment = .center
        }
    }
    
    lazy var logoContainer: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var logo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 150).isActive = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var titleText: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEditable = false
        view.isScrollEnabled = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    func setupViews(){
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(logoContainer)
        logoContainer.addSubview(logo)
        contentView.addSubview(titleText)
    }
    
    func setupConstraints(){
        logoContainer.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        logoContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        logoContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        logoContainer.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
        
        logo.centerYAnchor.constraint(equalTo: logoContainer.centerYAnchor).isActive = true
        logo.centerXAnchor.constraint(equalTo: logoContainer.centerXAnchor).isActive = true
        logo.heightAnchor.constraint(equalTo: logoContainer.heightAnchor, multiplier: 0.5).isActive = true
        
        titleText.topAnchor.constraint(equalTo: logoContainer.bottomAnchor).isActive = true
        titleText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
        titleText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true
        titleText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
