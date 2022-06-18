//
//  FeedViewModel.swift
//  Instagram
//
//  Created by William Tristão de Pauloa on 19/10/21.
//

import Foundation

class FeedViewModel {
    var feeds: [Feed] = dataToUse
    
    var reloadItem: ((IndexPath) -> Void)?
    
    func clickedToLikeFeed(indexPath: IndexPath) -> Void {
        self.feeds[indexPath.row].liked = !self.feeds[indexPath.row].liked
        self.reloadItem?(indexPath)
    }
}
