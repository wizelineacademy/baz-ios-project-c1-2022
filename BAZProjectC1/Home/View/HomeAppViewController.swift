//
//  HomeAppViewController.swift
//  BAZProjectC1
//
//  Created 1054812 on 14/09/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

final class HomeAppViewController: UIViewController {
    
    @IBOutlet weak private var collectionView: UICollectionView!
    
    weak var delegate: HomeViewControllerDelegate?
    
    private var movies: [Movie] = []
    private let movieApi = MovieAPI()
    private var leftBarButton = UIBarButtonItem()
    
    private var activeSearch = false
    private var searchedMovies: [Movie] = []
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureCollectionView()
        self.configureSearchController()
        
        self.leftBarButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(self.showMenu(_:)))
        self.leftBarButton.tintColor = .black
        self.navigationItem.leftBarButtonItem  = leftBarButton
        
        self.getMovies(filterSelected: .trending)
    }
    
    private func configureSearchController() {
        self.searchController.loadViewIfNeeded()
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.enablesReturnKeyAutomatically = false
        self.searchController.searchBar.returnKeyType = .done
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = true
        self.searchController.searchBar.placeholder = "Buscar película"
    }
    
    public func getMovies(filterSelected: FiltersMovies) {
        self.title = filterSelected.title
        self.movieApi.getMovies(url: filterSelected.url) { [weak self] movies in
            self?.movies = movies
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func configureCollectionView(){
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "movieCell")
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width:(width - 40)  / 2, height: 220)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        self.collectionView.collectionViewLayout = layout
    }
    
    @objc private func showMenu(_ sender: UIBarButtonItem) {
        self.delegate?.didTapMenuButton()
    }
}


// MARK:  - Extension CollectionViewDataSource.
extension HomeAppViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activeSearch ? self.searchedMovies.count : self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCell
        else {
            return UICollectionViewCell()
        }
        let movie = self.activeSearch ? self.searchedMovies[indexPath.row] : self.movies[indexPath.row]
        
        cell.nameMovie.text = movie.title
        
        cell.imgMovie.loadUrlImage(urlString: (GenericApiCall.baseImageURL + movie.posterPath))
        return cell
    }
}

extension HomeAppViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.activeSearch ? self.searchedMovies[indexPath.row] : self.movies[indexPath.row]
        
        let vc = DetailViewController(movie: movie)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeAppViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if !searchText.isEmpty {
            self.activeSearch = true
            self.searchedMovies.removeAll()
            for movie in self.movies {
                if movie.title.lowercased().contains(searchText.lowercased()) {
                    self.searchedMovies.append(movie)
                }
            }
        } else {
            self.activeSearch = false
            self.searchedMovies.removeAll()
            self.searchedMovies = self.movies
        }
        self.collectionView.reloadData()
    }
}

extension HomeAppViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.activeSearch = false
        self.searchedMovies.removeAll()
        self.collectionView.reloadData()
    }
}
