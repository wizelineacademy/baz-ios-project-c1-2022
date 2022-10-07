//  NowPlayingDetailViewController.swift
//  BAZProjectC1
//  Created by 291732 on 23/09/22.

import UIKit

final class NowPlayingDetailViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet weak var lblPTitle: UILabel!
    @IBOutlet weak var imgPMovie: UIImageView!
    @IBOutlet weak var lblPOverview: UILabel!
    @IBOutlet weak var lblPVote: UILabel!
    @IBOutlet weak var lblPYear: UILabel!
    @IBOutlet private weak var cvRecomended: UICollectionView!{
        didSet{
            self.cvRecomended.delegate = self
            self.cvRecomended.dataSource = self
            self.cvRecomended.register(UINib(nibName: "ElementCollectionViewCell",
                                             bundle: .main),
                                       forCellWithReuseIdentifier: ElementCollectionViewCell.identifier)
        }
    }
    
    //MARK: -  V A R I A B L E S
    var index: Int?
    var objMovie: MovieAPIResponse?
    
    //MARK: - F U N C T I O N S
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white
        self.setUpLeftMenu()
        self.setNowPlaying()
        self.getMovies()
    }
    
    private func setUpLeftMenu() {
        let menuBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                            style: .plain, target: self, action:  #selector(popView))
        navigationItem.leftBarButtonItem = menuBarButton
    }
    
    @objc private func popView(){
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - S E R V I C E S
    private func getMovies() {
        let movieApi = MovieAPI()
        movieApi.getMoviesTrending(withId: 3) { [weak self] moviesResponse, error in
            guard let self = self else{ return }
            if moviesResponse != nil {
                self.objMovie = moviesResponse
                DispatchQueue.main.async {
                    self.cvRecomended.reloadData()
                }
            }
        }
    }
    /// Imprime en el controlador la informacion que recibe dado un objeto de tipo NowPlaying y un indice dado
    private func setNowPlaying(){
        guard let index = index else { return }
        let dVote: Double = objMovie?.movies?[index].voteAverage ?? 0.0
        self.lblPTitle.text = objMovie?.movies?[index].title
        self.lblPOverview.text = objMovie?.movies?[index ].overview
        self.lblPVote.text = String(format: "%.1f", dVote )
        self.lblPYear.text = objMovie?.movies?[index ].releaseDate
        if let urlPoster = objMovie?.movies?[index].backdropPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            let _ = imgPMovie.loadImage(url: url)
        }
    }
}



//MARK: - EXT-> UI · C O L L E C T I O N · D E L E G A T E
extension NowPlayingDetailViewController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objMovie?.movies?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cCell = collectionView.dequeueReusableCell(withReuseIdentifier: ElementCollectionViewCell.identifier, for: indexPath) as? ElementCollectionViewCell ?? ElementCollectionViewCell()
        if let movie = objMovie?.movies?[indexPath.row] {
            cCell.setCell(with: movie)
        }
        return cCell
    }
}



//MARK: - EXT-> UI · C O L L E C T I O N · D E L E G A T E · F L O W · L A Y O U T
extension NowPlayingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 180, height: 248)
    }
}
