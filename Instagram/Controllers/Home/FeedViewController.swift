//
//  ViewController.swift
//  Instagram
//
//  Created by William Tristão de Pauloa on 13/10/21.
//

import UIKit

class FeedViewController: UIViewController {
    
    let viewModel = FeedViewModel()
    
    lazy var feedTableView: UITableView = {
        let view = UITableView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.estimatedRowHeight = 300
        view.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.self.description())
        view.allowsSelection = false
        view.accessibilityIdentifier = "table_feed"
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.reloadItem = self.reloadItem
        view.backgroundColor = .systemBackground
        
        view.addSubview(feedTableView)
        
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        feedTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        feedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        feedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    
    func reloadTable(indexPath: IndexPath) {
        self.feedTableView.beginUpdates()
        self.feedTableView.endUpdates()
    }
    
    func reloadItem(indexPath: IndexPath) -> Void {
        self.feedTableView.reloadRows(at: [indexPath], with: .none)
    }
    
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.self.description(), for: indexPath) as! FeedTableViewCell
        cell.viewModel = self.viewModel
        cell.indexPath = indexPath
        cell.feed = viewModel.feeds[indexPath.row]
        cell.reloadView = self.reloadTable
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

