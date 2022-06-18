//
//  PostCollectionView.swift
//  Instagram
//
//  Created by William Tristão de Pauloa on 13/10/21.
//

import UIKit

protocol PostCollectionViewDelegate {
    func onChangeCollectioViewHeight(height: CGFloat)
}

class PostCollectionView: NSObject {
    let postCollectionID = "postCollection"
    
    var content: [PostContent]? {
        didSet {
            guard let contentUnwrapped = content else {return}
            delegate?.onChangeCollectioViewHeight(height: contentUnwrapped[0].height)
        }
    }
    
    var delegate: PostCollectionViewDelegate?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = .zero
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isPagingEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.accessibilityIdentifier = "collection"
        return view
    }()
    
    override init() {
        super.init()
        setupViews()
        
    }
    
    func setupViews(){
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: postCollectionID)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension PostCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height = content?[0].height ?? 200
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCollectionID, for: indexPath) as! PostCollectionViewCell
        
        if let content = content?[indexPath.row] {
            cell.itemSlide = content
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let content = content else {return}
        let item = Int(targetContentOffset.pointee.x / collectionView.frame.width)
        delegate?.onChangeCollectioViewHeight(height: content[item].height)
        
    }
    
}
