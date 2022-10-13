//
//  MovieInformationController.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 22/09/22.
//

import Foundation
import UIKit

final class MovieDetailController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    public var movies:MovieData?
    private let movieCollectionIdentifier = "CollectionViewMovie"
    private let headerDetailIdentifier = "DetailMovieCell"
    private let headerTitleSections = "HeaderView"
    private let cellCreditsMovie = "CreditsMovie"
    private let collectionCastIdentifier = "CollectionViewCast"
    private var detailPresenter: CastPresenter?
    private var movieListPresenter: MovieListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadData()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: movieCollectionIdentifier, bundle: nil), forCellWithReuseIdentifier: movieCollectionIdentifier)
        collectionView.register(UINib(nibName: headerDetailIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerDetailIdentifier)
        collectionView.register(UINib(nibName: headerTitleSections, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerTitleSections)
        collectionView.register(UINib(nibName: cellCreditsMovie, bundle: nil), forCellWithReuseIdentifier: cellCreditsMovie)
        collectionView.register(UINib(nibName: collectionCastIdentifier, bundle: nil), forCellWithReuseIdentifier: collectionCastIdentifier)
    }
    
    private func loadData() {
        if let movieId = movies?.id {
            movieListPresenter = MovieListPresenter(view: self)
            movieListPresenter?.loadDataRecomendadas(using: collectionView, movieId: movieId)
            movieListPresenter?.loadDataSimilar(using: collectionView, movieId: movieId)
            detailPresenter = CastPresenter(view: self)
            detailPresenter?.loadCast(using: collectionView, movieId: movieId)
        }
    }
    
    public func presentView(for movieData: MovieData) {
        guard let vcMovieDetails =  self.storyboard?.instantiateViewController(withIdentifier: "infoview") as? MovieDetailController else { return }
        vcMovieDetails.movies = movieData
        self.navigationController?.pushViewController(vcMovieDetails, animated: true)
    }
}


extension MovieDetailController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCollectionIdentifier, for: IndexPath(row: indexPath.section, section: 0)) as? CollectionViewMovie else { return UICollectionViewCell() }
            return collectionCell
        case 1:
            return detailPresenter!.getCast(forRow: indexPath.section, using: collectionView, forPresent: self)
        case 2:
            return movieListPresenter!.getMovies(forRow: indexPath.section, using: collectionView, forPresent: self, typeOfMovie:  MovieListType.recommendation.rawValue)
        case 3:
            return movieListPresenter!.getMovies(forRow: indexPath.section, using: collectionView, forPresent: self,typeOfMovie: MovieListType.similar.rawValue)
            
        default:
            return UICollectionViewCell()
        }
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerDetailIdentifier, for: indexPath) as? DetailMovieCell else { return UICollectionReusableView () }
            header.movieTitle.text = movies?.title
            header.movieReview.text = movies?.overview
            if let imageMovie = movies?.posterPath, let averageCount = movies?.voteAverage {
                header.movieImage.downloaded(from: "https://image.tmdb.org/t/p/w500\(imageMovie)")
                header.movieRating.text = "Puntuacion: \(String(describing: Int(averageCount.rounded(.down))))/10"
            }
            return header
        case 1:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerTitleSections, for: indexPath) as? HeaderViewController else { return UICollectionReusableView() }
            header.titleLabel.text = "Reparto"
            return header
        case 2:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerTitleSections, for: indexPath) as? HeaderViewController else { return UICollectionReusableView() }
            header.titleLabel.text = "Peliculas Recomendadas"
            return header
        case 3:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerTitleSections, for: indexPath) as? HeaderViewController else { return UICollectionReusableView() }
            header.titleLabel.text = "Peliculas Similares"
            return header
        default:
            return UICollectionReusableView()
            
            
        }
    }
    
    
    
}

extension MovieDetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.size.width, height: CGFloat(0))
        case 1:
            return CGSize(width: collectionView.frame.size.width, height: CGFloat(350))
        case 2:
            return CGSize(width: collectionView.frame.size.width, height: CGFloat(300))
        case 3:
            return CGSize(width: collectionView.frame.size.width, height: CGFloat(300))
        default:
            return CGSize(width: collectionView.frame.size.width, height: CGFloat(100))
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch section {
        case 0:
            return CGSize(width: collectionView.frame.size.width, height: CGFloat(480))
        case 1:
            return CGSize(width: collectionView.frame.size.width, height: CGFloat(100))
        default:
            return CGSize(width: collectionView.frame.size.width, height: CGFloat(100))
        }
        
    }
}
