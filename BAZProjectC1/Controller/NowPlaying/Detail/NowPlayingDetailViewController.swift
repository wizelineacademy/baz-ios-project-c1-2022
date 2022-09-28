//  NowPlayingDetailViewController.swift
//  BAZProjectC1
//  Created by 291732 on 23/09/22.

import UIKit

final class NowPlayingDetailViewController: UIViewController {
    
    @IBOutlet weak var lblPTitle: UILabel!
    @IBOutlet weak var imgPMovie: UIImageView!
    @IBOutlet weak var lblPOverview: UILabel!
    @IBOutlet weak var lblPVote: UILabel!
    @IBOutlet weak var lblPYear: UILabel!
    @IBOutlet private weak var cvRecomended: UICollectionView!{
        didSet{
            self.cvRecomended.delegate = self
            self.cvRecomended.dataSource = self
            self.cvRecomended.register(UINib(nibName: "ElementCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CellRecomended")
        }
    }
    
    var index: Int?
    var objNowPlaying: NowPlayingAPIResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        self.setUpLeftMenu()
        self.setNowPlaying()
    }
    
    private func setUpLeftMenu() {
        let menuBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                            style: .plain, target: self, action:  #selector(popView))
        navigationItem.leftBarButtonItem = menuBarButton
    }
    
    @objc private func popView(){
        navigationController?.popViewController(animated: true)
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

extension NowPlayingDetailViewController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellRecomended", for: indexPath) as? ElementCollectionViewCell
        ?? ElementCollectionViewCell()
        return cCell
    }
    
    
}
