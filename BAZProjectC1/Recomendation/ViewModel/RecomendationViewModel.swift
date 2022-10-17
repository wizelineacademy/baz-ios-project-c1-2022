//
//  RecomendationViewModel.swift
//  BAZProjectC1
//
//  Created by efloresco on 16/10/22.
//

import Foundation

class RecomendationViewModel {
    
    private var objServ = MovieAPI()
    private var lstMovie: [MovieUpdate] = [] {
        didSet {
            self.bindData()
        }
    }
    
    var bindData: ( () -> ()) = {  }
    
     init() {
        callServices()
    }
    
    func callServices() {
        objServ.getRecomendations(completion: { [weak self] lstMov in
            self?.lstMovie = lstMov
        })
    }
    
    func movie(at index: Int) -> MovieUpdate {
        return lstMovie[index]
    }
    
    func getNumberOfItems() -> Int {
        return lstMovie.count
    }
}
