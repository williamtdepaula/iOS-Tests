//
//  LoginButton.swift
//  Instagram
//
//  Created by William Tristão de Pauloa on 17/10/21.
//

import UIKit

class LoginButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
        self.setTitle("Entrar", for: .normal)
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 5
        
    }
    
    func startLoad(){
        self.setTitle("Carregando", for: .normal)
    }

}
