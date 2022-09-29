//
//  MenuMoviesPresenter.swift
//  BAZProjectC1
//
//  Created by 961184 on 26/09/22.
//  
//

import Foundation

class MenuMoviesPresenter  {
    
    // MARK: Properties
    weak var view: MenuMoviesViewProtocol?
    var interactor: MenuMoviesInteractorInputProtocol?
    var router: MenuMoviesRouterProtocol?
    
}

extension MenuMoviesPresenter: MenuMoviesPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension MenuMoviesPresenter: MenuMoviesInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
