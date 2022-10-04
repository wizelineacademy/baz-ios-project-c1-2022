//
//  MovieInformationController.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 22/09/22.
//

import Foundation
import UIKit

final class MovieInformationController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    public var movies:MovieData?
    public var movieId:Int?
    public var movieImageUrl:String?
    public var movieOverview:String?
    public var movieTitle:String?
    public var movieRating:Double?
    private var similarMovies = Movie(results: [MovieData]())
    private var recommendsMovies = Movie(results: [MovieData]())
    private var castMovie = MovieCast(cast: [Cast]())
    private var actorsMovie = MovieList()
    private var similar = MovieList()
    private var recommends = MovieList()
    private let movieCollectionIdentifier = "CollectionViewMovie"
    private let headerDetailIdentifier = "InformationMovie"
    override func viewDidLoad() {
        super.viewDidLoad()
        //showDetails()
        setupView()
        loadDataSimilar()
        loadCast()
        loadDataRecomendadas()
    }
    
    /** Function that shows the details of the movie */
    private func showDetails() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func setupView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: movieCollectionIdentifier, bundle: nil), forCellWithReuseIdentifier: movieCollectionIdentifier)
        collectionView.register(UINib(nibName: headerDetailIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerDetailIdentifier)
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        collectionView.register(UINib(nibName: "CreditsMovie", bundle: nil), forCellWithReuseIdentifier: "CreditsMovie")
        collectionView.register(UINib(nibName: "CollectionViewCast", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCast")
    }
    
    private func loadDataSimilar() {
        similar.loadMoviesSimilar(with: "similar", completion: { (movie) in
            self.similarMovies = movie
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }, movieId!)
    }
    
    private func loadDataRecomendadas() {
        recommends.loadMoviesSimilar(with: "recommendations", completion: { (movie) in
            self.recommendsMovies = movie
            print("************  \(self.recommendsMovies)")
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }, movieId!)
    }
    

    
    
    public func loadCast()  {
        actorsMovie.loadMoviesCast(with: "credits", completion: { (cast) in
            self.castMovie = cast
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }, movieId!)

    }
    func openDetails(for asset: MovieData, with rail: Movie) {
        
            guard let vcMovieDetails =  self.storyboard?.instantiateViewController(withIdentifier: "infoview") as? MovieInformationController else { return }
            vcMovieDetails.movies = asset
            vcMovieDetails.movieOverview = asset.overview
            vcMovieDetails.movieImageUrl = asset.backdropPath
            vcMovieDetails.movieId = asset.id
            vcMovieDetails.movieRating = asset.voteAverage
            vcMovieDetails.movieTitle = asset.title
            self.navigationController?.pushViewController(vcMovieDetails, animated: true)
    }
}


extension MovieInformationController: UICollectionViewDataSource {
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
            guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCast", for: indexPath) as? CollectionViewCast else { return UICollectionViewCell() }
            collectionCell.loadData(actorsMovie: castMovie)
            return collectionCell
            
        case 2:
            guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCollectionIdentifier, for: IndexPath(row: indexPath.section, section: 0)) as? CollectionViewMovie else { return UICollectionViewCell() }
            collectionCell.loadData(movies: recommendsMovies)
            collectionCell.onSelect = { [unowned self] rail, asset in
                self.openDetails(for: asset, with: rail)

            }
            return collectionCell
        case 3:
            guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCollectionIdentifier, for: IndexPath(row: indexPath.section, section: 0)) as? CollectionViewMovie else { return UICollectionViewCell() }
            collectionCell.loadData(movies: similarMovies)
            collectionCell.onSelect = { [unowned self] rail, asset in
                self.openDetails(for: asset, with: rail)
            }
            return collectionCell

        default:
            return UICollectionViewCell()
        }

        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerDetailIdentifier, for: indexPath) as? InformationMovie
            header?.movieTitle.text = movieTitle
            header?.movieReview.text = movieOverview
            header?.movieImage.downloaded(from: "https://image.tmdb.org/t/p/w500\(movieImageUrl!)")
            header?.movieRating.text = "Puntuacion: \(String(describing: Int(movieRating!.rounded(.down))))/10"
            return header!
        case 1:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderViewController
            header?.titleLabel.text = "Reparto"
            return header!
        case 2:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderViewController
            header?.titleLabel.text = "Peliculas Recomendadas"
            return header!
        case 3:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderViewController
            header?.titleLabel.text = "Peliculas Similares"
            return header!
        default:
            return UICollectionReusableView()
            
            
        }
    }
    
    
    
}

extension MovieInformationController: UICollectionViewDelegateFlowLayout {
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
