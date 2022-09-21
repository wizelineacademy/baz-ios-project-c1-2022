//
//  TrendingViewController.swift
//  BAZProjectC1
//
//

import UIKit

class HomeMovieViewController: UIViewController {

    @IBOutlet weak var filterSectionCollection: UICollectionView!
    @IBOutlet weak var movieTableView: UITableView!

    private var movies: Movies = []
    private let genres = ["Trending", "Now Playing", "Popular", "Top Rated", "Upcoming"]
    private var selectedGenre = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionAndTableView()
        getMovies()
    }

    private func getMovies() {
        MovieAPI.shared.getMovies(genre: self.genres[self.selectedGenre].lowercased().replacingOccurrences(of: " ", with: "_")) { [weak self] movies in
            self?.movies = movies
            DispatchQueue.main.async { [weak self] in
                self?.movieTableView.reloadData()
            }
        }
    }

    private func setupCollectionAndTableView() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
        filterSectionCollection.delegate = self
        filterSectionCollection.dataSource = self
        filterSectionCollection.register(UINib(nibName: "FilterSectionCollectionViewCell", bundle: Bundle(for: HomeMovieViewController.self)),
                                         forCellWithReuseIdentifier: "FilterSectionCell")
    }
}

// MARK: - TableView's DataSource
extension HomeMovieViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell")!
    }
}

// MARK: - TableView's Delegate
extension HomeMovieViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title
        config.image = UIImage(named: "poster")
        cell.contentConfiguration = config
    }
}

// MARK: CollectionView's DataSource
extension HomeMovieViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        genres.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterSectionCell", for: indexPath) as! FilterSectionCollectionViewCell
        filterCell.titleFilter.text = genres[indexPath.row]
        if selectedGenre == indexPath.row { filterCell.enableState() }
        else { filterCell.disableState() }
        return filterCell
    }
}

// MARK: CollectionView's Delegate
extension HomeMovieViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedGenre = indexPath.row
        getMovies()
        collectionView.reloadData()
    }
}

// MARK: CollectionView's FlowLayout
extension HomeMovieViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing = 10
        let itemWidth = genres[indexPath.row].count * 10
        let cellWidth = itemWidth + itemSpacing
        return CGSize(width: cellWidth, height: 36)
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
