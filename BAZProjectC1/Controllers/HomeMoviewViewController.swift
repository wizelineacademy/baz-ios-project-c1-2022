//
//  TrendingViewController.swift
//  BAZProjectC1
//
//

import UIKit

class HomeMovieViewController: UIViewController {

    // MARK: Class properties -
    @IBOutlet weak var filterSectionCollection: UICollectionView!
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private var movieTableDataSource: CategoryMovieTableDataSource?
    private var movieTableDelegate: CategoryMovieTableDelegate?
    private var movies: Movies = []
    private let genres = ["Trending", "Now Playing", "Popular", "Top Rated", "Upcoming"]
    private var selectedGenre = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionAndTableView()
        getMovies()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetailMovie" {
            let detailMovieScreen: DetailMovieViewController = segue.destination as! DetailMovieViewController
            detailMovieScreen.movie = sender as? Movie
        }
    }

    private func getMovies() {
        activityIndicator.startAnimating()
        MovieNetworkManager.shared.fetchMovies(genre: genres[selectedGenre].lowercased()) { [weak self] objectResponse, error in
            guard let objectResponse = objectResponse,
                  let movies = objectResponse.results else { return }
            self?.movies = movies
            DispatchQueue.main.async {
                self?.movieTableDataSource?.reloadData(with: movies, using: self?.movieTableView ?? UITableView())
                self?.activityIndicator.stopAnimating()
                self?.view.isUserInteractionEnabled = true
            }
        }
    }

    private func setupCollectionAndTableView() {
        filterSectionCollection.register(UINib(nibName: "FilterSectionCollectionViewCell", bundle: Bundle(for: HomeMovieViewController.self)), forCellWithReuseIdentifier: "FilterSectionCell")
        movieTableView.register(UINib(nibName: "CategoryMovieTableViewCell", bundle: Bundle(for: HomeMovieViewController.self)), forCellReuseIdentifier: "CategoryMovieCell")
        movieTableDataSource = CategoryMovieTableDataSource(with: movies)
        movieTableDelegate = CategoryMovieTableDelegate(using: self)
        movieTableView.delegate = movieTableDelegate
        movieTableView.dataSource = movieTableDataSource
        filterSectionCollection.delegate = self
        filterSectionCollection.dataSource = self
    }
}

// MARK: CollectionView's DataSource
extension HomeMovieViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        genres.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterSectionCell", for: indexPath) as! FilterSectionCollectionViewCell
        filterCell.titleFilter.text = genres[indexPath.item]
        if selectedGenre == indexPath.item { filterCell.enableState() }
        else { filterCell.disableState() }
        return filterCell
    }
}

// MARK: HomeMovieViewController's CategoryMovieCellProtocol
extension HomeMovieViewController: CategoryMovieCellProtocol {

    func didSelectMovie(_ index: Int) {
        performSegue(withIdentifier: "goDetailMovie", sender: movies[index])
    }
}

// MARK: CollectionView's Delegate
extension HomeMovieViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedGenre != indexPath.item {
            selectedGenre = indexPath.item
            getMovies()
            collectionView.reloadData()
        }
    }
}

// MARK: CollectionView's FlowLayout
extension HomeMovieViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing = 12
        let itemWidth = genres[indexPath.item].count * 11
        let cellWidth = itemWidth + itemSpacing
        return CGSize(width: cellWidth, height: 34)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 8)
    }
}
