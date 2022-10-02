//
//  DetailMoviePresenter.swift
//  BAZProjectC1
//
//  Created by 961184 on 26/09/22.
//  
//

import Foundation

class DetailMoviePresenter: DetailMoviePresenterProtocol {
    
    
    // MARK: Properties
    weak var view: DetailMovieViewProtocol?
    var interactor: DetailMovieInteractorInputProtocol?
    var router: DetailMovieRouterProtocol?
    var movieDetailData: MovieDetail?
    private var similarMovies: [Movie] = []
    
    // MARK: - DetailMoviePresenterProtocol functions
    func viewDidLoad() {
        interactor?.getMovieSimilar(idMovie: movieDetailData?.id ?? 0)
    }
    
    func getSimilarMoviesCount() -> Int {
        self.similarMovies.count
    }
    
    func getSimilarMovie(indexPathRow: Int) -> Movie {
        self.similarMovies[indexPathRow]
    }
    
    func getMovieDetail(idMovie: Int) {
        interactor?.getMovieDetail(idMovie: idMovie)
    }
    
}

// MARK: - DetailMovieInteractorOutputProtocol
extension DetailMoviePresenter: DetailMovieInteractorOutputProtocol {
    
    // MARK: - DetailMovieInteractorOutputProtocol functions
    func pushSimilarMoviesData(similarMoviesData: [Movie]) {
        self.similarMovies = similarMoviesData
        self.view?.reloadCollectionViewData()
    }
    
    func pushMovieDetailData(movieData: MovieDetail) {
        if let view = view {
            view.catchResponse(withMessage: nil)
            router?.goToMovieDetail(movieDetailData: movieData, view: view)
        }
    }
    
    func catchResponse(withMessage: String) {
        view?.catchResponse(withMessage: withMessage)
    }
}
