//
//  DetailMoviePresenter.swift
//  BAZProjectC1
//
//  Created by 961184 on 26/09/22.
//  
//

import Foundation

class DetailMoviePresenter  {
    
    // MARK: Properties
    weak var view: DetailMovieViewProtocol?
    var interactor: DetailMovieInteractorInputProtocol?
    var router: DetailMovieRouterProtocol?
    
}

extension DetailMoviePresenter: DetailMoviePresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension DetailMoviePresenter: DetailMovieInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
