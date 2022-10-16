//
//  DetailMoviesViewController.swift
//  BAZProjectC1
//
//  Created by rnunezi on 28/09/22.
//

import UIKit

//MARK: - DetailMoviesViewController

class DetailMoviesViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgPoster: ImageView!
    @IBOutlet weak var btnOption: UIButton!
    private let urlBaseImg = "https://image.tmdb.org/t/p/w500"
    public var detailMovie: DetailMovie?
    public var delegateMovies: FavoriteMovieCollectionProtocol?
    public var isMovieOriginal:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ConstantsDetailMovies.titleDetail
        navigationController?.navigationBar.backgroundColor = .cyan
        NotificationCenter.default.addObserver(self,selector:#selector(notificationRecived),name: Notification.Name("colorChanged"),object: nil )
        setData()
    }
    
    //Method: Notification center set background color
    @objc func notificationRecived (){
        view.backgroundColor = .cyan
    }
    
    //Method: Set data from detail movie
    func setData(){
        
        self.lblTitle.text = detailMovie?.title
        self.lblDescription.text = detailMovie?.overview
        self.imgPoster.loadImage(urlStr: "\(urlBaseImg)\(detailMovie?.poster_path ?? "" )")
        if isMovieOriginal {
            btnOption.titleLabel?.text = ConstantsDetailMovies.titleButtonAddMovies
        }
        else {
            btnOption.titleLabel?.text = ConstantsDetailMovies.titleButtonRemoveMovies
            btnOption.imageView?.image = UIImage(systemName: "house")
        }
    }
    
    //Method: Button to add favorites or remove them
    @IBAction func btnOption(_ sender: Any) {
        
        if isMovieOriginal {
            delegateMovies?.addFavoriteMovies(detailMovie)
        }
        else {
            delegateMovies?.removeFavoriteMovies(detailMovie)
        }
        
        self.dismiss(animated: true) {
            self.navigationController?.popToRootViewController(animated: true)
        }
        
    }
}
