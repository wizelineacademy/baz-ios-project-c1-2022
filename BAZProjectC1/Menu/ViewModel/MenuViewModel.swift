//
//  MenuViewModel.swift
//  BAZProjectC1
//
//  Created by efloresco on 16/10/22.
//

import Foundation

class MenuViewModel {
    
    private var objServ = MovieAPI()
    private var lstMovie: [MovieUpdate] = [] {
        didSet {
            self.bindData()
        }
    }
    
    var bindData: ( () -> ()) = { }
     init() {
       callServices()
    }
    
    func callServices() {
        objServ.getMostPopular(completion: { [weak self] lstInfo in
            self?.lstMovie = lstInfo
        })
    }
    
    func movie(at index: Int) -> MovieUpdate {
        return lstMovie[index]
    }
    
    func getNumberOfItems() -> Int {
        return lstMovie.count
    }
}
