//
//  FeedTableViewCell.swift
//  Instagram
//
//  Created by William Tristão de Pauloa on 13/10/21.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    var viewModel: FeedViewModel?
    
    var feed: Feed? {
        didSet {
            guard let feedUnwrapped = feed else { return }
            
            userName.text = feedUnwrapped.userName
            profileImage.image = UIImage(named: feedUnwrapped.userProfilePic)
            descLabel.text = feedUnwrapped.description
            posts.content = feedUnwrapped.posts
            likedIndicator.text = feedUnwrapped.liked ? "GOSTEI" : "REAGIR"
        }
    }
    
    var indexPath: IndexPath? = nil
    
    var reloadView: ((IndexPath) -> Void)? = nil
    
    lazy var profileImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        
        view.image = UIImage(named: "will")
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let viewSize: CGFloat = 50
        
        view.widthAnchor.constraint(equalToConstant: viewSize).isActive = true
        view.heightAnchor.constraint(equalToConstant: viewSize).isActive = true
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = viewSize / 2
        
        return view
    }()
    
    lazy var userName: UILabel = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.text = "William Tristão de Paula"
        
        view.font = UIFont.boldSystemFont(ofSize: 16)
        
        view.numberOfLines = 1
        
        return view
    }()
    
    lazy var iconOption: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(systemName: "ellipsis")
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.contentMode = .scaleToFill
        
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        view.tintColor = .black
        
        return view
    }()
    
    lazy var descLabel: UILabel = {
        let view = UILabel()
                
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.textColor = .black
        
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        view.numberOfLines = 3
        
        return view
    }()
    
    lazy var likedIndicator: UILabel = {
        let view = UILabel()
        view.text = "REAGIR"
        view.font = UIFont.boldSystemFont(ofSize: 13)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPressToLikeFeed(sender:))))
        view.textColor = .systemBlue
        view.accessibilityIdentifier = "button_react"
        return view
    }()
    
    lazy var posts: PostCollectionView = {
        let view = PostCollectionView()
        view.collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    @objc
    func onPressToLikeFeed(sender: UITapGestureRecognizer) {
        guard let viewModel = viewModel, let indexPath = self.indexPath else {
            return
        }

        viewModel.clickedToLikeFeed(indexPath: indexPath)
    }
    
    var slidePostsConstraints: NSLayoutConstraint?
    var descConstraints: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        self.contentView.addSubview(profileImage)
        self.contentView.addSubview(userName)
        self.contentView.addSubview(iconOption)
        self.contentView.addSubview(posts.collectionView)
        self.contentView.addSubview(descLabel)
        self.contentView.addSubview(likedIndicator)
        
        profileImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        profileImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true

        userName.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        userName.leadingAnchor.constraint(equalTo:  profileImage.trailingAnchor, constant: 10).isActive = true
        userName.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true

        iconOption.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        iconOption.centerYAnchor.constraint(equalTo: userName.centerYAnchor).isActive = true
        
        posts.collectionView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10).isActive = true
        posts.collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        posts.collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        slidePostsConstraints = posts.collectionView.heightAnchor.constraint(equalToConstant: 0)
        slidePostsConstraints?.priority = UILayoutPriority(998)
        slidePostsConstraints?.isActive = true
        
        descLabel.topAnchor.constraint(equalTo: posts.collectionView.bottomAnchor, constant: 10).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
        likedIndicator.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 10).isActive = true
        likedIndicator.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        likedIndicator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        
    }
}

extension FeedTableViewCell: PostCollectionViewDelegate {
    func onChangeCollectioViewHeight(height: CGFloat) {
        slidePostsConstraints?.constant = height
        guard let indexPath = self.indexPath else {return}
        self.reloadView?(indexPath)
    }
}
