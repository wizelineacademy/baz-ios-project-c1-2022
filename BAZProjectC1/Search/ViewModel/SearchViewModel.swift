//
//  SearchViewModel.swift
//  BAZProjectC1
//
//  Created by efloresco on 16/10/22.
//

import Foundation

class SearchViewModel {
    
    private var objServ = MovieAPI()
    private var lstMovie: [MovieUpdate] = [] {
        didSet { 
            self.bindData()
        }
    }
    
    var bindData: ( () -> ()) = { }
    
    init() {
        
    }
    
    func callServices(strDatos: String) {
        objServ.getQuerySearch(strQuery: strDatos, completion: { [weak self] lst in
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
