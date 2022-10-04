//
//  TrendingViewController.swift
//  BAZProjectC1
//
//

import UIKit

enum TypeMovie {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upComing
    case searched(String)
    
    var url: MovieAPI {
        switch self {
        case .trending:
            return MovieAPI(url: "https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
        case .nowPlaying:
            return MovieAPI(url: "https://api.themoviedb.org/3/movie/now_playing?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
        case .popular:
            return MovieAPI(url: "https://api.themoviedb.org/3/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
        case .topRated:
            return MovieAPI(url: "https://api.themoviedb.org/3/movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
        case .upComing:
            return MovieAPI(url: "https://api.themoviedb.org/3/movie/upcoming?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
        case let .searched(typed):
            return MovieAPI(url: "https://api.themoviedb.org/3/search/movie?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&query=\(typed)")
        }
    }
}

protocol MyDataSendingDelegate: AnyObject {
    func sendData(myData: Movie)
}

final internal class TrendingViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    private var movies: [Movie] = []
    private var typeMovie: TypeMovie = .trending
    var imageArray: [UIImage] = []
    weak var delegate: MyDataSendingDelegate? = nil
    
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "MovieMainListCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: MovieMainListCollectionViewCell.identifier)
        fetchMovies()
        configureSearch()
        configureSegmentedControll()
    }
    
    func configureSegmentedControll() {
        segmentedControl.setTitle("Now Playing", forSegmentAt: 0)
        segmentedControl.setTitle("Popular", forSegmentAt: 1)
        segmentedControl.setTitle("Top Rated", forSegmentAt: 2)
        segmentedControl.setTitle("Upcoming", forSegmentAt: 3)
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
//        print(sender.selectedSegmentIndex)
        switch sender.selectedSegmentIndex {
        case 0:
            typeMovie = .trending
        case 1:
            typeMovie = .nowPlaying
        case 2:
            typeMovie = .popular
        case 3:
            typeMovie = .topRated
        case 4:
            typeMovie = .upComing
        default:
            typeMovie = .trending
        }
        fetchMovies()
    }
    
    func fetchMovies() {
        imageArray.removeAll()
        DispatchQueue.global().async {
            let service = self.typeMovie.url
            service.getMovies { [weak self] (result, wasSuccess) in
                if wasSuccess {
                    self?.movies = result
                }
            }
            
            print(self.movies)
            DispatchQueue.main.sync {
                self.collectionView.reloadData()
            }
        }
    }
    
    func configureSearch() {
        searchController.loadViewIfNeeded()
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Movie"
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController")
        let controller = viewController as? MovieDetailsViewController
        controller?.movie = movies[indexPath.row]
        controller?.img = imageArray[indexPath.row]
        navigationController?.pushViewController(controller ?? UIViewController(), animated: true)
    }
}

extension TrendingViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchedText = searchController.searchBar.text {
            typeMovie = .searched(searchedText)
            fetchMovies()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        collectionView.reloadData()
    }
    
}

protocol TrendingViewControllerFetcherDelegate {
    func fetchMovies()
    func retreiveImageFromSource(posterPath: String) -> UIImage
}

