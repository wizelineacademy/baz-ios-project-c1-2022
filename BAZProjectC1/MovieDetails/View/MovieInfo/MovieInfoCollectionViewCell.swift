//
//  MovieInfoCollectionViewCell.swift
//  BAZProjectC1
//
//  Created by 1030361 on 03/10/22.
//

import UIKit

final internal class MovieInfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var moviesSimilars: [MovieSimilars]?
    var moviesRecomended: [MovieRecomended]?
    var castArray: [Cast]?
    var image: UIImage?
    var bMovies: SegmentSelected?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    private func setupCell() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MovieMainListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieMainListCollectionViewCell")
    }
    
    private func retreiveImageFromSource(posterPath: String) -> UIImage {
        let apiURLHandler = APIURLHandler(url: "https://image.tmdb.org/t/p/w500/\(posterPath)")
        let uiImage = UIImage(data: apiURLHandler.getDataFromURL() ?? Data()) ?? UIImage()
        return uiImage
    }
}

// MARK: - TrendingViewController's DataSource and Delegate
extension MovieInfoCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch bMovies {
        case .similar(0):
            return moviesSimilars?.count ?? 0
        case .recommended(0):
            return moviesRecomended?.count ?? 0
        case .cast(0):
            return castArray?.count ?? 0
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieMainListCollectionViewCell", for: indexPath) as? MovieMainListCollectionViewCell else { return UICollectionViewCell() }

        switch bMovies {
        case .similar(0):
            cell.setLabel(text: moviesSimilars?[indexPath.row].title ?? "")
            let image = retreiveImageFromSource(posterPath: moviesSimilars?[indexPath.row].posterPath ?? "")
            cell.setImage(img: image)
        case .recommended(0):
            cell.setLabel(text: moviesRecomended?[indexPath.row].title ?? "")
            let image = retreiveImageFromSource(posterPath: moviesRecomended?[indexPath.row].posterPath ?? "")
            cell.setImage(img: image)
        case .cast(0):
            cell.setLabel(text: castArray?[indexPath.row].name ?? "")
            let image = retreiveImageFromSource(posterPath: castArray?[indexPath.row].profilePath ?? "")
            cell.setImage(img: image)
        default:
            return cell
        }
        
        return cell
    }
    
}
