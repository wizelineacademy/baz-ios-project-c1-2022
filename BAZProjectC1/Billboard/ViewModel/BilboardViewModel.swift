//
//  BilboardViewModel.swift
//  BAZProjectC1
//
//  Created by efloresco on 16/10/22.
//

import Foundation

class BilboardViewModel {
    
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
        objServ.getMoviesUpdate(completion: { [weak self] lstResult in
            self?.lstMovie = lstResult
        })
    }
    
    func movie(at index: Int) -> MovieUpdate {
        return lstMovie[index]
    }
    
    func getNumberOfItems() -> Int {
        return lstMovie.count
    }
}
