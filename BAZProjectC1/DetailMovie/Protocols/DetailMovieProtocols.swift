//
//  DetailMovieProtocols.swift
//  BAZProjectC1
//
//  Created by 961184 on 26/09/22.
//  
//

import Foundation
import UIKit

protocol DetailMovieViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: DetailMoviePresenterProtocol? { get set }
    
    func reloadCollectionViewData()
    func catchResponse(withMessage: String?)
}

protocol DetailMovieRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createDetailMovieModule(movieDetailData: MovieDetail) -> UIViewController
    
    func goToMovieDetail(movieDetailData: MovieDetail, view: DetailMovieViewProtocol)
}

protocol DetailMoviePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: DetailMovieViewProtocol? { get set }
    var interactor: DetailMovieInteractorInputProtocol? { get set }
    var router: DetailMovieRouterProtocol? { get set }
    var movieDetailData: MovieDetail? { get set }
    
    func viewDidLoad()
    
    func getSimilarMoviesCount() -> Int
    func getSimilarMovie(indexPathRow: Int) -> Movie
    func getMovieDetail(idMovie: Int)
}

protocol DetailMovieInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    func pushSimilarMoviesData(similarMoviesData: [Movie])
    func pushMovieDetailData(movieData: MovieDetail)
    
    func catchResponse(withMessage: String)
}

protocol DetailMovieInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: DetailMovieInteractorOutputProtocol? { get set }
    var remoteDatamanager: DetailMovieRemoteDataManagerInputProtocol? { get set }
    
    func getMovieSimilar(idMovie: Int)
    func getMovieDetail(idMovie: Int)
}

protocol DetailMovieDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol DetailMovieRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: DetailMovieRemoteDataManagerOutputProtocol? { get set }
    
    func getMovieSimilar(idMovie: Int)
    func getMovieDetail(idMovie: Int)
}

protocol DetailMovieRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func pushSimilarMoviesData(similarMoviesData: [Movie])
    func pushMovieDetailData(movieData: MovieDetail)
    func catchResponse(withMessage: String)
}
