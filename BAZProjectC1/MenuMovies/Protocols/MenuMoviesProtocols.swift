//
//  MenuMoviesProtocols.swift
//  BAZProjectC1
//
//  Created by 961184 on 26/09/22.
//  
//

import Foundation
import UIKit

protocol MenuMoviesViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: MenuMoviesPresenterProtocol? { get set }
    var navigationController: UINavigationController? { get set }
    func reloadCollectionViewData()
    func reloadCollectionViewSearchedData()
    func catchResponse(withMessage: String?)
}

protocol MenuMoviesRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createMenuMoviesModule() -> UIViewController
    
    func goToMovieDetail(movieDetailData: MovieDetail, view: MenuMoviesViewProtocol)
}

protocol MenuMoviesPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: MenuMoviesViewProtocol? { get set }
    var interactor: MenuMoviesInteractorInputProtocol? { get set }
    var router: MenuMoviesRouterProtocol? { get set }
    var selectedCategory: CategoryMovieType? { get set }
    var selectedLanguage: ApiLanguageResponse? { get set }
    
    func viewDidLoad()
    func getMovieCount() -> Int
    func getMovie(indexPathRow: Int) -> Movie
    
    func getSearchedMovieCount() -> Int
    func getSearchedMovie(indexPathRow: Int) -> Movie
    
    func getSearchedMovies(searchTerm: String)
    func getMovieDetail(idMovie: Int)
}

protocol MenuMoviesInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    func pushMoviesData(moviesData: [Movie])
    func pushSearchedMoviesData(moviesData: [Movie])
    func pushMovieDetailData(movieData: MovieDetail)
    
    func catchResponse(withMessage: String)
}

protocol MenuMoviesInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: MenuMoviesInteractorOutputProtocol? { get set }
    var remoteDatamanager: MenuMoviesRemoteDataManagerInputProtocol? { get set }
    
    func getMovies(categoryMovieType: CategoryMovieType)
    func getSearchedMovies(searchTerm: String)
    func getMovieDetail(idMovie: Int)
}

protocol MenuMoviesDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol MenuMoviesRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: MenuMoviesRemoteDataManagerOutputProtocol? { get set }
    func getMovies(categoryMovieType: CategoryMovieType)
    func getSearchedMovies(searchTerm: String)
    func getMovieDetail(idMovie: Int)
}

protocol MenuMoviesRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func pushMoviesData(moviesData: [Movie])
    func pushSearchedMoviesData(moviesData: [Movie])
    func pushMovieDetailData(movieData: MovieDetail)
    
    func catchResponse(withMessage: String)
}
