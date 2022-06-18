//
//  WelcomeViewController.swift
//  Instagram
//
//  Created by William Tristão de Pauloa on 17/10/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
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
        
        var attributedText = NSMutableAttributedString(
            string: "Seja bem-vindo ao Instagram",
            attributes:[NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)]
        )
        
        attributedText.append(NSMutableAttributedString(
            string: "\n\nConecte-se com amigos, compartilhe o que você está fazendo ou veja as novidades de outras pessoas no mundo todo.",
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        ))
        
        view.attributedText = attributedText
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.isEditable = false
        view.isScrollEnabled = false
        return view
    }()
    
    lazy var prevButton: UIButton = {
        let view = UIButton()
        view.setTitle("VOLTAR", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(.systemGray, for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let view = UIButton()
        view.setTitle("PRÓXIMO", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(.systemGray, for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return view
    }()
    
    lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        view.currentPage = 0
        view.numberOfPages = 4
        view.currentPageIndicatorTintColor = .red
        view.pageIndicatorTintColor = .gray
        view.backgroundStyle = .minimal
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupBottomViews()
        setupConstraints()
    }
    
    func setupViews(){
        view.backgroundColor = .systemBackground
        view.addSubview(logoContainer)
        logoContainer.addSubview(logo)
        view.addSubview(titleText)
    }
    
    func setupConstraints(){
        logoContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        logoContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        logoContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        logoContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        logo.centerYAnchor.constraint(equalTo: logoContainer.centerYAnchor).isActive = true
        logo.centerXAnchor.constraint(equalTo: logoContainer.centerXAnchor).isActive = true
        logo.heightAnchor.constraint(equalTo: logoContainer.heightAnchor, multiplier: 0.5).isActive = true
        
        titleText.topAnchor.constraint(equalTo: logoContainer.bottomAnchor).isActive = true
        titleText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        titleText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        titleText.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func setupBottomViews(){
        
        let stack = UIStackView(arrangedSubviews: [prevButton, pageControl, nextButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stack.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
}
