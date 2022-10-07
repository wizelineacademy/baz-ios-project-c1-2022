//  DetailViewController.swift
//  BAZProjectC1
//  Created by 291732 on 06/10/22.

import UIKit

class DetailViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblVote: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var cvRecomended: UICollectionView!
    
    private var downloadTask: URLSessionDownloadTask?
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInfo(with: movie)
        self.setGradientOnImage()
        self.setUpLeftMenu()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setUpLeftMenu() {
        let menuBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                            style: .plain, target: self, action:  #selector(popView))
        navigationItem.leftBarButtonItem = menuBarButton
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func popView(){
        navigationController?.popViewController(animated: true)
    }
    
    private func setGradientOnImage(){
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: imgPoster.frame.width, height: imgPoster.frame.height)
        let startColor = UIColor.clear.cgColor
        let endColor = UIColor.black.cgColor
        gradient.colors = [startColor, endColor]
        imgPoster.layer.insertSublayer(gradient, at: 0)
    }

    func setInfo(with obj: Movie?){
        let dVote: Double = obj?.voteAverage ?? 0.0
        self.lblTitle.text = obj?.title
        self.lblDesc.text = obj?.overview
        self.lblVote.text = String(format: "%.1f", dVote )
        self.lblDate.text = obj?.releaseDate
        if let urlPoster = obj?.backdropPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            let _ = imgPoster.loadImage(url: url)
        }
    }
}
