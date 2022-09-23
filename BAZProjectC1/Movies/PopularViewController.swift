//
//  PopularViewController.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 21/09/22.
//

import Foundation
import UIKit

final class PopularViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let reuseIdentifier = "moviecard"
    private var movies = Movie(results: [MovieData]())
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollection()
        getMovies()
    }
    
    private func configCollection() {
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MovieCardCell", bundle: nil), forCellWithReuseIdentifier: "moviecard")
    }
    
    private func getMovies() {
        NetworkManager().fetchMovieData { [weak self] (page, error) in
            guard let self = self else { return }
            if let page = page {
                self.movies = page
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                print("No movies found")
            }
        }
    }
}

extension PopularViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MovieCardCellController else { return UICollectionViewCell() }
        cell.movieTitle.text = movies.results[indexPath.row].title
        cell.movieImage.downloaded(from: "https://image.tmdb.org/t/p/w500\(movies.results[indexPath.row].posterPath)")
        cell.movieReleaseDate.text = movies.results[indexPath.row].releaseDate
        cell.movieVotes.text = String(movies.results[indexPath.row].voteCount)
        cell.movieCardDelegate = self
        cell.idMovieCard = indexPath.row
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.collectionView.frame.width/2)-8 , height: (self.collectionView.frame.height/3.5))
    }
    
}

extension PopularViewController: MovieCardProtocol {
    
    func clickEvent(movieId: Int) {
        guard let vcMovieDetails =  self.storyboard?.instantiateViewController(withIdentifier: "infoview") as? MovieInformationController else { return }
        vcMovieDetails.id = movieId
        self.present(vcMovieDetails, animated: true, completion: nil)
    }
}
