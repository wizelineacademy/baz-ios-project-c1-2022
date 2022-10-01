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
        MovieNetworkManager.shared.fetchMovies(genre: genres[selectedGenre].lowercased().replacingOccurrences(of: " ", with: "_")) { [weak self] objectResponse, error in
            guard let objectResponse = objectResponse,
            let movies = objectResponse.results else { return }
            self?.movies = movies
            DispatchQueue.main.async {
                self?.movieTableView.reloadData()
            }
        }
    }

    private func setupCollectionAndTableView() {
        filterSectionCollection.register(UINib(nibName: "FilterSectionCollectionViewCell", bundle: Bundle(for: HomeMovieViewController.self)), forCellWithReuseIdentifier: "FilterSectionCell")
        movieTableView.register(UINib(nibName: "CategoryMovieTableViewCell", bundle: Bundle(for: HomeMovieViewController.self)), forCellReuseIdentifier: "CategoryMovieCell")
        movieTableView.delegate = self
        movieTableView.dataSource = self
        filterSectionCollection.delegate = self
        filterSectionCollection.dataSource = self
    }
}

// MARK: - TableView's DataSource
extension HomeMovieViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "CategoryMovieCell", for: indexPath) as! CategoryMovieTableViewCell
        MovieNetworkManager.shared.downloadImage(imagePath: movies[indexPath.row].poster_path ?? "", width: 200) { [weak self] image in
            DispatchQueue.main.async {
                movieCell.titleMovieLabel.text = self?.movies[indexPath.row].title
                movieCell.posterMovie.image = image ?? UIImage(named: "poster")
            }
        }
        return movieCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        114.00
    }
}

// MARK: - TableView's Delegate
extension HomeMovieViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goDetailMovie", sender: movies[indexPath.row])
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
        let itemSpacing = 12
        let itemWidth = genres[indexPath.row].count * 11
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
