//
//  UpcomingViewModel.swift
//  BAZProjectC1
//
//  Created by efloresco on 16/10/22.
//

import Foundation

class UpcomingViewModel {
    
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
        objServ.getUpComing(completion: { [weak self] lst in
            self?.lstMovie = lst
        })
    }
    
    func movie(at index: Int) -> MovieUpdate {
        return lstMovie[index]
    }
    
    func getNumberOfItems() -> Int {
        return lstMovie.count
    }
}
