//
//  TagsViewController.swift
//  Instagram
//
//  Created by William Tristão de Pauloa on 18/10/21.
//

import UIKit

class TagsViewController: UIViewController {
    let cell = "cell"
    let viewModel = TagsViewModel()
    
    lazy var containerCollection: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var containerinputField: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(TagCell.self, forCellWithReuseIdentifier: cell)
        view.isHidden = viewModel.items.count == 0
        return view
    }()
    
    lazy var inputField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.placeholder = "Digite algo..."
        view.setLeftPaddingPoints(10)
        return view
    }()
    
    lazy var saveButton: UIButton = {
        let view = UIButton()
        view.setTitle("Salvar", for: .normal)
        view.setTitleColor(UIColor.systemBlue, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.textColor = . systemBlue
        view.addTarget(self, action: #selector(pressToSave), for: .touchUpInside)
        return view
    }()
    
    lazy var emptyList: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Sem nenhum item no momento"
        view.numberOfLines = 2
        view.textColor = UIColor.black
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 16)
        return view
    }()
    
    override func viewDidLoad() {
        viewModel.delegate = self
        setupViews()
        setupConstraints()
    }
    
    func setupViews(){
        view.backgroundColor = .systemBackground
        view.addSubview(containerCollection)
        view.addSubview(containerinputField)
        containerCollection.addSubview(emptyList)
        containerCollection.addSubview(collection)
        containerinputField.addSubview(inputField)
        containerinputField.addSubview(saveButton)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            containerCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerCollection.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
        NSLayoutConstraint.activate([
            containerinputField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            containerinputField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerinputField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerinputField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
        NSLayoutConstraint.activate([
            emptyList.topAnchor.constraint(equalTo: containerCollection.topAnchor),
            emptyList.leadingAnchor.constraint(equalTo: containerCollection.leadingAnchor),
            emptyList.trailingAnchor.constraint(equalTo: containerCollection.trailingAnchor),
            emptyList.bottomAnchor.constraint(equalTo: containerCollection.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: containerCollection.topAnchor),
            collection.leadingAnchor.constraint(equalTo: containerCollection.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: containerCollection.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: containerCollection.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            inputField.centerXAnchor.constraint(equalTo: containerinputField.centerXAnchor),
            inputField.centerYAnchor.constraint(equalTo: containerinputField.centerYAnchor),
            inputField.leadingAnchor.constraint(equalTo: containerinputField.leadingAnchor),
            inputField.trailingAnchor.constraint(equalTo: containerinputField.trailingAnchor),
        ])
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: inputField.bottomAnchor, constant: 10),
            saveButton.leadingAnchor.constraint(equalTo: containerinputField.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: containerinputField.trailingAnchor),
        ])
    }
    
    @objc func pressToSave(){
        guard let text = inputField.text, text.count > 0 else {return}
        viewModel.addItem(text)
        inputField.text = ""
    }
    
    @objc func pressToDeleteItem(button: UIButton){
        viewModel.removeItem(index: button.tag)
    }
}

//MARK: Collection
extension TagsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath) as! TagCell
        
        cell.text = viewModel.items[indexPath.row]
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(pressToDeleteItem), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = widthForView(viewModel.items[indexPath.row], font: UIFont.boldSystemFont(ofSize: 14), height: 36)
        return CGSize(width: cellWidth + 40, height: 36)
    }
    
    func widthForView(_ text: String, font: UIFont, height: CGFloat) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.width
    }
    
}

//MARK: View Model Delegate
extension TagsViewController: TagsViewModelDelagete {
    func onListStateChange(visible: Bool) {
        emptyList.isHidden = visible
        collection.isHidden = !visible
    }
    
    func onListUpdate() {
        collection.reloadData()
    }
    
}
