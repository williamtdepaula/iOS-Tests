//
//  SwipingController.swift
//  Instagram
//
//  Created by William Tristão de Pauloa on 18/10/21.
//

import UIKit

class SwipingController: UICollectionViewController {
    let pages: [Page] = [
        Page(
            imageName: "logo",
            title: "Seja bem-vindo ao Instagram",
            description: "\n\nConecte-se com amigos, compartilhe o que você está fazendo ou veja as novidades de outras pessoas no mundo todo."
        ),
        Page(
            imageName: "logo",
            title: "Teste2",
            description: "\n\nSuper descrição"
        ),
        Page(
            imageName: "logo",
            title: "Teste2",
            description: "\n\nSuper descrição"
        )
    ]
    
    lazy var prevButton: UIButton = {
        let view = UIButton()
        view.setTitle("VOLTAR", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(.systemGray, for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        view.addTarget(self, action: #selector(onPressPrev), for: .touchUpInside)
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let view = UIButton()
        view.setTitle("PRÓXIMO", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(.systemGray, for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        view.addTarget(self, action: #selector(onPressNext), for: .touchUpInside)
        return view
    }()
    
    lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        view.currentPage = 0
        view.numberOfPages = pages.count
        view.currentPageIndicatorTintColor = .red
        view.pageIndicatorTintColor = .gray
        view.backgroundStyle = .minimal
        view.isUserInteractionEnabled = false
        return view
    }()
    
    @objc func onPressNext() {
        if(pageControl.currentPage == (pages.count-1)){
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true)
        }else{
            let nextPage = pageControl.currentPage + 1
            scrollPage(page: nextPage)
            pageControl.currentPage = nextPage
        }
    }
    
    @objc func onPressPrev() {
        let nextPage = pageControl.currentPage == 0 ? 0 : pageControl.currentPage - 1
        scrollPage(page: nextPage)
        pageControl.currentPage = nextPage
    }
    
    func scrollPage(page: Int){
        let indexPath = IndexPath(item: page, section: 0)
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.isPagingEnabled = true
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let nextPage = Int(targetContentOffset.pointee.x / view.frame.width)
        
        pageControl.currentPage = nextPage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.isPagingEnabled = true
        
        collectionView.showsHorizontalScrollIndicator = false
        
        setupBottomViews()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: {_ in
            self.collectionViewLayout.invalidateLayout()
            
            if(self.pageControl.currentPage == 0 ){
                self.collectionView.contentOffset = .zero
            }else{
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                
                self.collectionView.isPagingEnabled = false
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                self.collectionView.isPagingEnabled = true
            }
            
        }, completion: {something in
            
        })
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PageCell
        
        cell.page = pages[indexPath.row]
        
        return cell
    }
    
}

extension SwipingController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height + view.safeAreaInsets.top)
    }
}
