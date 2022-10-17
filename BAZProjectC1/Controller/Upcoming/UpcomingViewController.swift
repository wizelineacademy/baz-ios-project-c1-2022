//  UpcomingViewController.swift
//  BAZProjectC1
//  Created by 291732 on 22/09/22.

import UIKit

final class UpcomingViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet private weak var cvUpcoming: UICollectionView!{
        didSet{
            self.cvUpcoming.delegate = self
            self.cvUpcoming.dataSource = self
            self.cvUpcoming.register(UINib(nibName: "UpcomingCollectionViewCell", bundle: .main),
                                       forCellWithReuseIdentifier: UpcomingCollectionViewCell.identifier)
        }
    }
    
    //MARK: - V A R I A B L E S
    private var objMovie: MovieAPIResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Upcoming"
        self.getMovies()
    }
    
    //MARK: - S E R V I C E S
    private func getMovies() {
        let movieApi = MovieAPI()
        movieApi.getMoviesCategory(withURL: MovieCategory.upcoming.rawValue) { [weak self] moviesResponse, error in
            guard let self = self else{ return }
            if moviesResponse != nil {
                self.objMovie = moviesResponse
                DispatchQueue.main.async {
                    self.cvUpcoming.reloadData()
                }
            }
        }
    }
}


//MARK: - EXT-> UI · C O L L E C T I O N · V I E W · D E L E G A T E
extension UpcomingViewController: UICollectionViewDelegate & UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objMovie?.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cCell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCollectionViewCell.identifier,
                                                       for: indexPath) as? UpcomingCollectionViewCell ?? UpcomingCollectionViewCell()
        if let upcoming = objMovie?.movies?[indexPath.row] {
            cCell.setCell(with: upcoming)
        }
        return cCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = DetailViewController()
        if let movie = objMovie?.movies?[indexPath.row] {
            detail.movie = movie
        }
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.pushViewController(detail, animated: true)
    }
}


//MARK: - EXT-> UI · C O L L E C T I O N · D E L E G A T E · F L O W · L A Y O U T
extension UpcomingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2 , height: 240)
    }
}
