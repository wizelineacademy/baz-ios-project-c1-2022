//
//  TrendingViewController.swift
//  BAZProjectC1
//
//

import UIKit

final internal class TrendingViewController: UICollectionViewController, TrendingViewControllerFetcherDelegate {

    private var movies: [Movie] = []
    private let movieApi = MovieAPI(url: "https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
    var imageArray: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.register(MovieMainListCollectionViewCell.self, forCellWithReuseIdentifier: MovieMainListCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: "MovieMainListCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: MovieMainListCollectionViewCell.identifier)
        fetchMovies()
//        let width = (view.frame.width-20)/3
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize(width: width, height: width)
    }
    
    func fetchMovies() {
        DispatchQueue.global().async {
            self.movies = self.movieApi.getMovies()
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

    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 25
//    }
    
}

// MARK: - TableView's UICollectionViewDataSource
/*
extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailVC = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: .main)
        movieDetailVC.movie = movies[indexPath.row]
        movieDetailVC.img = imageArray[indexPath.row]
        movieDetailVC.modalPresentationStyle = .fullScreen
        self.present(movieDetailVC, animated: true, completion: nil)
    }

}

// MARK: - TableView's UICollectionViewDataSource
extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title
        config.image = retreiveImageFromSource(posterPath: movies[indexPath.row].posterPath)
        cell.contentConfiguration = config
    }

}
*/

// MARK: - TrendingViewController's DataSource and Delegate
extension TrendingViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

//    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
//        return 2
//    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//            // In this function is the code you must implement to your code project if you want to change size of Collection view
//            let width  = (view.frame.width-20)/3
//            return CGSize(width: 0, height: 0)
//    }
//    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("sizeForItemAt")
        return CGSize(width: 250, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieMainListCollectionViewCell", for: indexPath) as? MovieMainListCollectionViewCell else { return UICollectionViewCell() }
        
//        collectionView.
        
        cell.setLabel(text: "\(movies[indexPath.row].title)")
        let image = retreiveImageFromSource(posterPath: movies[indexPath.row].posterPath)
        cell.setImage(img: image)
//        cell.lblName.text = "\(indexPath.row)"
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailVC = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: .main)
        movieDetailVC.movie = movies[indexPath.row]
        movieDetailVC.img = imageArray[indexPath.row]
        movieDetailVC.modalPresentationStyle = .fullScreen
        self.present(movieDetailVC, animated: true, completion: nil)
    }
}



protocol TrendingViewControllerFetcherDelegate {
    func fetchMovies()
    func retreiveImageFromSource(posterPath: String) -> UIImage
}
