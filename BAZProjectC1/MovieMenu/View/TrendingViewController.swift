//
//  TrendingViewController.swift
//  BAZProjectC1
//
//

import UIKit

final internal class TrendingViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    private var movies: [Movie] = []
    private var typeMovie: TypeMovie = .trending
    private var imageArray: [UIImage] = []
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setUpNotificaionCenter()
        fetchMovies()
        configureSearch()
        configureSegmentedControll()
    }
    
    func setUpNotificaionCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
           return
        }
        print("self.view.frame.origin.y \(self.view.frame.origin.y)")
        self.view.frame.origin.y = 0 - keyboardSize.height
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
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
    
    private func fetchMovies() {
        imageArray.removeAll()
        DispatchQueue.global().async {
            let service = self.typeMovie.url
            service.getMovies { [weak self] (result, wasSuccess) in
                if wasSuccess {
                    self?.movies = result
                }
            }
            DispatchQueue.main.sync {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func configureSearch() {
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
        imageArray.append(image)
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

// MARK: - TrendingViewController's ResultsUpdating and BarDelegate
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

// MARK: - TrendingViewController's ViewControllerCommonsDelegate
extension TrendingViewController: ViewControllerCommonsDelegate {
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "MovieMainListCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: MovieMainListCollectionViewCell.identifier)
    }
    
    func configureSegmentedControll() {
        segmentedControl.setTitle("Now Playing", forSegmentAt: 0)
        segmentedControl.setTitle("Popular", forSegmentAt: 1)
        segmentedControl.setTitle("Top Rated", forSegmentAt: 2)
        segmentedControl.setTitle("Upcoming", forSegmentAt: 3)
    }
    
    func retreiveImageFromSource(posterPath: String) -> UIImage {
        let apiURLHandler = APIURLHandler(url: "https://image.tmdb.org/t/p/w500/\(posterPath)")
        let uiImage = UIImage(data: apiURLHandler.getDataFromURL() ?? Data()) ?? UIImage()
        return uiImage
    }
}
