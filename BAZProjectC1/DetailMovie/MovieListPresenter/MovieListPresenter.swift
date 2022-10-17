//
//  MovieListPresenter.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 04/10/22.
//

import UIKit

final class MovieListPresenter {
    
    //MARK: - Properties
    private var movie:MovieListProtocol = MovieList()
    private var similarMovies = Movie(results: [MovieData]())
    private var recommendsMovies = Movie(results: [MovieData]())
    private let reuseIndentifier = "CollectionViewMovie"
    private weak var view: MovieDetailController?
    
    //MARK: - Methods
    init(view: MovieDetailController) {
        self.view = view
    }
    
    /**
     Function that loads the similar movies of a specific movie
     - Parameters:
     - collectionView: collection that show the movies
     - movieId: id of the movie
     */
    public func loadDataSimilar(using collectionView: UICollectionView, movieId: Int) {
            movie.loadMoviesDetail(with: MovieListType.similar.rawValue, completion: { (movie) in
                self.similarMovies = movie
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
            }, movieId)
    }
    
    /**
     Function that loads the recommends movies of a specific movie
     - Parameters:
     - collectionView: collection that show the movies
     - movieId: id of the movie
     */
    public func loadDataRecomendadas(using collectionView: UICollectionView, movieId: Int) {
            movie.loadMoviesDetail(with: "recommendations", completion: { (movie) in
                self.recommendsMovies = movie
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
            }, movieId)
    }
    
    /**
     Function that show the view of detail movie
     - Parameters:
     - asset: object of movie data
     - rail: object of movie
     - viewController: view that present the new view
     */
    private func openDetails(for asset: MovieData, with rail: Movie, using viewController: UIViewController) {
        view?.presentView(for: asset)
    }
    
    /**
     Function that get movies
     - Parameters:
     - row: number of row
     - collectionView: collection that show the movies
     - typeOfMovie: filter type similar  or recommended
     */
    public func getMovies(forRow row: Int, using collectionView: UICollectionView, forPresent viewController: UIViewController, typeOfMovie: String) -> UICollectionViewCell {
        switch typeOfMovie {
        case MovieListType.similar.rawValue :
            guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIndentifier, for: IndexPath(row: row, section: 0)) as? CollectionViewMovie else { return UICollectionViewCell() }
            collectionCell.loadData(movies: similarMovies)
            collectionCell.onSelect = { [unowned self] rail, asset in
                self.openDetails(for: asset, with: rail, using: viewController)
            }
            return collectionCell
        case MovieListType.recommendation.rawValue:
            guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIndentifier, for: IndexPath(row: row, section: 0)) as? CollectionViewMovie else { return UICollectionViewCell() }
            collectionCell.loadData(movies: recommendsMovies)
            collectionCell.onSelect = { [unowned self] rail, asset in
                self.openDetails(for: asset, with: rail, using: viewController)
            }
            return collectionCell
        default:
            return UICollectionViewCell()
        }

    }

}
