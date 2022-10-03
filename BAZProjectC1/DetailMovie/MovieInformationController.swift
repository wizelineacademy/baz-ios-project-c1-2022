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
    public var movieRating:Int?
    private var similarMovies = Movie(results: [MovieData]())
    private var castMovie = MovieCast(cast: [Cast]())
    private var actorsMovie = MovieList()
    private var similar = MovieList()
    private let movieCollectionIdentifier = "CollectionViewMovie"
    private let headerDetailIdentifier = "InformationMovie"
    override func viewDidLoad() {
        super.viewDidLoad()
        showDetails()
        setupView()
        loadDataSimilar()
        loadCast()
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
    

    
    
    public func loadCast()  {
        actorsMovie.loadMoviesCast(with: "credits", completion: { (cast) in
            self.castMovie = cast
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }, movieId!)

    }
    
}


extension MovieInformationController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
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
            collectionCell.loadData(movies: similarMovies)
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
            header?.movieRating.text = "CALIFICATION:\(String(describing: movieRating!))"
            return header!
        case 1:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderViewController
            header?.titleLabel.text = "Reparto"
            return header!
        case 2:
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
            return CGSize(width: collectionView.frame.size.width, height: CGFloat(450))
        case 2:
            return CGSize(width: collectionView.frame.size.width, height: CGFloat(300))
        default:
            return CGSize(width: collectionView.frame.size.width, height: CGFloat(100))
            
        }

    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch section {
        case 0:
            return CGSize(width: collectionView.frame.size.width, height: CGFloat(400))
        case 1:
            return CGSize(width: collectionView.frame.size.width, height: CGFloat(100))
        default:
            return CGSize(width: collectionView.frame.size.width, height: CGFloat(100))
        }

    }
}
