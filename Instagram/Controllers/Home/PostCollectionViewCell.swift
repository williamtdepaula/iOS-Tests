//
//  PostCellCollectionViewCollectionViewCell.swift
//  Instagram
//
//  Created by William Tristão de Pauloa on 13/10/21.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    var imageHeightConstraint: NSLayoutConstraint?
    
    var itemSlide: PostContent? {
        didSet {
            guard let itemSlideUnwrapped = itemSlide else { return }
            imagePost.image = UIImage(named: itemSlideUnwrapped.file)
            imagePost.accessibilityIdentifier = itemSlideUnwrapped.file
            imageHeightConstraint?.constant = itemSlideUnwrapped.height
        }
    }
    
    lazy var imagePost: UIImageView = {
        
        let view = UIImageView()
                
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.clipsToBounds = true
        
        view.contentMode = .scaleToFill
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        self.addSubview(imagePost)
        
        imageHeightConstraint = imagePost.heightAnchor.constraint(equalToConstant: 0)
        imageHeightConstraint?.priority = UILayoutPriority(999)
        imageHeightConstraint?.isActive = true
        imagePost.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imagePost.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imagePost.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
