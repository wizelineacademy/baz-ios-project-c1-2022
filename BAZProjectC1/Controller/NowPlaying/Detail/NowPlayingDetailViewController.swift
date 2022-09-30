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
    var objNowPlaying: NowPlayingAPIResponse?
    var objPopular: PopularAPIResponse?
    
    //MARK: - F U N C T I O N S
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white
        self.setUpLeftMenu()
        self.setNowPlaying()
        self.getPopular()
    }
    
    private func setUpLeftMenu() {
        let menuBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                            style: .plain, target: self, action:  #selector(popView))
        navigationItem.leftBarButtonItem = menuBarButton
    }
    
    @objc private func popView(){
        navigationController?.popViewController(animated: true)
    }
    
    
    private func getPopular(){
        let movie_WS = MovieAPI()
        movie_WS.getPopular { [weak self] popularResponse, error in
            guard let self = self else{ return }
            if popularResponse != nil {
                self.objPopular = popularResponse
                DispatchQueue.main.async {
                    self.cvRecomended.reloadData()
                }
            }
        }
    }
    
    /// Imprime en el controlador la informacion que recibe dado un objeto de tipo NowPlaying y un indice dado
    private func setNowPlaying(){
        guard let index = index else { return }
        let dVote: Double = objNowPlaying?.nowPlaying?[index].voteAverage ?? 0.0
        self.lblPTitle.text = objNowPlaying?.nowPlaying?[index].title
        self.lblPOverview.text = objNowPlaying?.nowPlaying?[index ].overview
        self.lblPVote.text = String(format: "%.1f", dVote )
        self.lblPYear.text = objNowPlaying?.nowPlaying?[index ].releaseDate
        if let urlPoster = objNowPlaying?.nowPlaying?[index].backdropPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            let _ = imgPMovie.loadImage(url: url)
        }
    }
}



//MARK: - EXT-> UI · C O L L E C T I O N · D E L E G A T E
extension NowPlayingDetailViewController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objPopular?.popular?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cCell = collectionView.dequeueReusableCell(withReuseIdentifier: ElementCollectionViewCell.identifier, for: indexPath) as? ElementCollectionViewCell ?? ElementCollectionViewCell()
        if let movie = objPopular?.popular?[indexPath.row] {
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
