//
//  TrendingViewController.swift
//  BAZProjectC1
//
//

import UIKit

final internal class TrendingViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var movies: [Movie] = []
    private let movieApi = MovieAPI(url: "https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
    var imageArray: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "MovieMainListCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: MovieMainListCollectionViewCell.identifier)
        fetchMovies()
    }
    
    func fetchMovies() {
        DispatchQueue.global().async {
            self.movies = self.movieApi.getMovies()
            print(self.movies)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func retreiveImageFromSource(posterPath: String) -> UIImage {
        let apiURLHandler = APIURLHandler(url: "https://image.tmdb.org/t/p/w500/\(posterPath)")
        let uiImage = UIImage(data: apiURLHandler.getDataFromURL() ?? Data()) ?? UIImage()
        imageArray.append(uiImage)
        return uiImage
    }
}

// MARK: - TrendingViewController's DataSource and Delegate
extension TrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieMainListCollectionViewCell", for: indexPath) as? MovieMainListCollectionViewCell else { return UICollectionViewCell() }
        cell.setLabel(text: "\(movies[indexPath.row].title)")
        let image = retreiveImageFromSource(posterPath: movies[indexPath.row].posterPath)
        cell.setImage(img: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let movieDetailVC = MovieDetailsViewController(nibName: "Main", bundle: nil)
//        movieDetailVC.movie = movies[indexPath.row]
//        movieDetailVC.img = imageArray[indexPath.row]
//        movieDetailVC.modalPresentationStyle = .fullScreen
//        self.present(movieDetailVC, animated: true, completion: nil)
//
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
}



protocol TrendingViewControllerFetcherDelegate {
    func fetchMovies()
    func retreiveImageFromSource(posterPath: String) -> UIImage
}

