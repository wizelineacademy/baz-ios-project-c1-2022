//
//  TrendingViewModel.swift
//  BAZProjectC1
//
//  Created by efloresco on 16/10/22.
//

import Foundation

class TrendingViewModel : NSObject {
    
    private var objServ = MovieAPI()
    private(set) var lstMovie: [MovieUpdate] = [] {
        didSet {
            self.bindData()
        }
    }
    
    var bindData: ( () -> ()) = { }
    
    override init() {
        super.init()
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

