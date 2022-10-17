//
//  MoviePresenter.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 29/09/22.
//

import UIKit

final class MoviePresenter {
    
    //MARK: - Properties
    private var moviesTrending = Movie(results: [MovieData]())
    private var moviesPlaying = Movie(results: [MovieData]())
    private var moviesPopular = Movie(results: [MovieData]())
    private var moviesTop = Movie(results: [MovieData]())
    private var moviesUpcoming = Movie(results: [MovieData]())
    private var treding:MovieListProtocol = MovieList()
    private var nowPlaying:MovieListProtocol = MovieList()
    private var Popular:MovieListProtocol = MovieList()
    private var topRated:MovieListProtocol = MovieList()
    private var upcoming:MovieListProtocol = MovieList()
    private weak var view: HomeMoviesViewController?
    
    //MARK: - Methods
    init(view: HomeMoviesViewController) {
        self.view = view
    }
    
    /**
     Function that loads the movies in their different sections
     - Parameters:
     - collectionView: collectionView that show the movies
     */
    public func loadMovies(using collectionView: UICollectionView) {
        treding.loadMoviesTrending { (movie) in
            self.moviesTrending = movie
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
        nowPlaying.loadMovies(with: "now_playing") { (movie) in
            self.moviesPlaying = movie
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
        Popular.loadMovies(with: "popular") { (movie) in
            self.moviesPopular = movie
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
        topRated.loadMovies(with: "top_rated") { (movie) in
            self.moviesTop = movie
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
        upcoming.loadMovies(with: "upcoming") { (movie) in
            self.moviesUpcoming = movie
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
    }
    
    /**
     Function that shows the view of open details of the movie
     - Parameters:
     - asset: object of MovieData
     - rail: object of Movie
     - viewController:  view controller that show  the new view
     */
    private func openDetails(for asset: MovieData, with rail: Movie, using viewController: UIViewController) {
        view?.presentView(for: asset)
    }
    
    /**
     Function that obtains the movies of the different sections that exist
     - Parameters:
     - row:number of row
     - collectionView: collection that show the movies
     - viewController: viewcontroller that show the new view
     */
    func getMovies(forRow row: Int, using collectionView: UICollectionView, forPresent viewController: UIViewController) -> UICollectionViewCell {
        guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewMovie", for: IndexPath(row: row, section: 0)) as? CollectionViewMovie else { return UICollectionViewCell() }
        switch row {
        case 0:
            collectionCell.loadData(movies: moviesTrending)
            collectionCell.onSelect = { [unowned self] rail, asset in
                self.openDetails(for: asset, with: rail, using: viewController)
            }
        case 1:
            collectionCell.loadData(movies: moviesPlaying)
            collectionCell.onSelect = { [unowned self] rail, asset in
                self.openDetails(for: asset, with: rail, using: viewController)
            }
        case 2:
            collectionCell.loadData(movies: moviesPopular)
            collectionCell.onSelect = { [unowned self] rail, asset in
                self.openDetails(for: asset, with: rail, using: viewController)
            }
        case 3:
            collectionCell.loadData(movies: moviesTop)
            collectionCell.onSelect = { [unowned self] rail, asset in
                self.openDetails(for: asset, with: rail, using: viewController)
            }
        case 4:
            collectionCell.loadData(movies: moviesUpcoming)
            collectionCell.onSelect = { [unowned self] rail, asset in
                self.openDetails(for: asset, with: rail, using: viewController)
            }
        default:
            return UICollectionViewCell()
        }
        return collectionCell
    }
}

