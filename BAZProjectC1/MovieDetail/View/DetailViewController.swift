//
//  DetailViewController.swift
//  BAZProjectC1
//
//  Created by 1054812 on 22/09/22.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let movie: MovieDetail
    
    init(movie: MovieDetail) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.setupView()
    }
    
    private func setupView() {
        self.collectionView.register(UINib(nibName: "DetailMovieCell", bundle: nil), forCellWithReuseIdentifier: "DetailMovieCell")
        self.collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        collectionView.register(UINib(nibName: "HeaderSection", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(HeaderSection.self)")
    }
}

//MARK: Extension UITableViewDataSource
extension DetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1:
            return movie.credits.cast.count
        case 2:
            return movie.similar.results.count
        case 3:
            return movie.recommendations.results.count
        case 4:
            return movie.reviews.results.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderSection", for: indexPath) as? HeaderSection else {
            return UICollectionReusableView()
        }
        headerView.backgroundColor = UIColor.white
        
        switch indexPath.section {
        case 1:
            headerView.titleSection.text = "Créditos"
        case 2:
            headerView.titleSection.text = "Películas Similares"
        case 3:
            headerView.titleSection.text = "Películas recomendadas"
        case 4:
            headerView.titleSection.text = "Reseñas"
        default:
            headerView.titleSection.text = ""
        }
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height = section != 0 ? 50.0 : 0
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCell else {
                return UICollectionViewCell()
            }
            cell.imgMovie.loadUrlImage(urlString: "\(GenericApiCall.baseImageURL)\(movie.credits.cast[indexPath.item].profilePath ?? "")")
            cell.nameMovie.text = movie.credits.cast[indexPath.item].name
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCell else {
                return UICollectionViewCell()
            }
            cell.imgMovie.loadUrlImage(urlString: "\(GenericApiCall.baseImageURL)\(movie.similar.results[indexPath.item].posterPath)")
            cell.nameMovie.text = movie.similar.results[indexPath.item].title
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCell else {
                return UICollectionViewCell()
            }
            cell.imgMovie.loadUrlImage(urlString: "\(GenericApiCall.baseImageURL)\(movie.recommendations.results[indexPath.item].posterPath)")
            cell.nameMovie.text = movie.recommendations.results[indexPath.item].title
            return cell
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCell else {
                return UICollectionViewCell()
            }
            cell.imgMovie.isHidden = true
            cell.nameMovie.text = movie.reviews.results[indexPath.item].content
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailMovieCell", for: indexPath) as? DetailMovieCell else {
                return UICollectionViewCell()
            }
            cell.nameMovie.text = movie.title
            cell.averageMovie.text = String(format: "%.2f", movie.voteAverage)
            cell.overviewMovie.text = movie.overview
            cell.imgMovie.loadUrlImage(urlString: ("\(GenericApiCall.baseImageURL)\(movie.posterPath)"))
            
            return cell
        }
    }
}

// MARK: CollectionView's FlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            let width = UIScreen.main.bounds.width
            let itemSize = CGSize(width:(width - 50), height: 700)
            
            return itemSize
        default:
            let itemSize = CGSize(width: 100, height: 170)
            
            return itemSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 25, bottom: 0, right: 25)
    }
}
