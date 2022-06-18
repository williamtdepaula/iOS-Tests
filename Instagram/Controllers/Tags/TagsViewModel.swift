//
//  TagsViewModel.swift
//  Instagram
//
//  Created by William Tristão de Pauloa on 19/10/21.
//

import Foundation

protocol TagsViewModelDelagete {
    func onListUpdate()
    func onListStateChange(visible: Bool)
}

class TagsViewModel {
    var items: [String] = [] {
        didSet {
            delegate?.onListStateChange(visible: items.count > 0)
        }
    }
    
    var delegate: TagsViewModelDelagete?
    
    func addItem(_ item: String){
        items.append(item)
        delegate?.onListUpdate()
    }
    
    func removeItem(index: Int){
        items.remove(at: index)
        delegate?.onListUpdate()
    }
}
