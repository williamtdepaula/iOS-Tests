//
//  LoginViewController.swift
//  Instagram
//
//  Created by William Tristão de Pauloa on 17/10/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var rootView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backgroundGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        
        gradient.colors = [UIColor(named: "gradient-1")?.cgColor ?? UIColor.white.cgColor, UIColor(named: "gradient-2")?.cgColor ?? UIColor.white.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        return gradient
    }()
    
    lazy var logo: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "insta")
        return view
    }()
    
    lazy var loginInput: UITextField = {
        let view = UITextField(frame: .zero)
        view.backgroundColor = UIColor(white: 1, alpha: 0.3)
        view.layer.cornerRadius = 5
        view.placeholderCustom(placeholder: "E-mail", color: .white)
        view.setLeftPaddingPoints(10)
        view.textColor = .white
        return view
    }()
    
    lazy var passwordInput: UITextField = {
        let view = UITextField()
        view.backgroundColor = UIColor(white: 1, alpha: 0.3)
        view.layer.cornerRadius = 5
        view.placeholderCustom(placeholder: "Senha", color: .white)
        view.textColor = .white
        view.setLeftPaddingPoints(10)
        view.isSecureTextEntry = true
        return view
    }()
    
    lazy var buttonLogin: LoginButton = {
        let view = LoginButton()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    func setupViews(){
        view.addSubview(rootView)
        
        rootView.frame = view.bounds
        rootView.addSubview(logo)
        rootView.addSubview(loginInput)
        rootView.addSubview(passwordInput)
        rootView.addSubview(buttonLogin)
        
        backgroundGradient.frame = rootView.bounds
        
        rootView.layer.insertSublayer(backgroundGradient, at: 0)
        
        loginInput.delegate = self
        passwordInput.delegate = self
        
        buttonLogin.addTarget(self, action: #selector(pressToLogin), for: .touchUpInside)
    }
    
    func setupConstraints(){
        logo.frame = CGRect(x: (view.frame.size.width/2)-100, y: 50, width: 200, height: 70)
        loginInput.frame = CGRect(x: 25, y: (view.frame.height/2) - 100, width: view.frame.size.width-50, height: 50)
        passwordInput.frame = CGRect(x: 25, y: loginInput.frame.maxY + 10, width: view.frame.size.width-50, height: 50)
        buttonLogin.frame = CGRect(x: 25, y: passwordInput.frame.maxY + 20, width: view.frame.size.width-50, height: 50)
    }
    
    @objc func pressToLogin(){
        buttonLogin.startLoad()
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin editing", textField.text ?? "")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("end editing",textField.text ?? "")
    }
}
