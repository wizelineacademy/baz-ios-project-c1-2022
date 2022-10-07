//
//  DetailMovieView.swift
//  BAZProjectC1
//
//  Created by 961184 on 26/09/22.
//  
//

import Foundation
import UIKit

class DetailMovieView: UIViewController {
    
    @IBOutlet weak private var imgMovie: UIImageView!
    @IBOutlet weak private var lblTitle: UILabel!
    @IBOutlet weak private var lblDetails: UILabel!
    @IBOutlet weak private var txvOverview: UITextView!
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var collectionMovieRelated: UICollectionView!
    
    
    @IBOutlet weak var heightContentView: NSLayoutConstraint!
    private let urlBase = "https://image.tmdb.org/t/p/w500"
    
    
    // MARK: - Properties of collectionMovieRelated configuration
    let numberOfSections = 1
    let insets: CGFloat = 8
    let heightAditionalConstant : CGFloat = 75
    let minimumLineSpacing: CGFloat = 10
    let minimumInteritemSpacing: CGFloat = 10
    let cellsPerRow:Int = 3

    // MARK: - Properties
    var presenter: DetailMoviePresenterProtocol?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.lblTitle.text = presenter?.movieDetailData?.title
        self.lblDetails.text = "\(presenter?.movieDetailData?.original_title ?? "") | \(presenter?.movieDetailData?.genres?.first?.name ?? "") | \(presenter?.movieDetailData?.release_date ?? "")\(presenter?.movieDetailData?.adult ?? false ? " | 18+": " | 18-")"
        self.txvOverview.text = presenter?.movieDetailData?.overview == nil || presenter?.movieDetailData?.overview == "" ? "Sin reseña" : presenter?.movieDetailData?.overview
        self.imgMovie.loadImage(urlStr: "\(urlBase)\(presenter?.movieDetailData?.poster_path ?? "")")
        collectionMovieRelated.register(UINib(nibName: "MovieItemCollectionViewCell", bundle: Bundle(for: MovieItemCollectionViewCell.self)), forCellWithReuseIdentifier: "MovieItemCollectionViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = presenter?.movieDetailData?.title
    }
}

// MARK: - DetailMovieViewProtocol
extension DetailMovieView: DetailMovieViewProtocol {

    /**
     Function that reloads the collectionMovieRelated and assigns his delegates.
     */
    func reloadCollectionViewData() {
        DispatchQueue.main.async {
            self.collectionMovieRelated.delegate = self
            self.collectionMovieRelated.dataSource = self
            self.collectionMovieRelated.reloadData()
        }
    }
    
    /**
     Function that removes the loading animation and shows an alert in case of an error ocurred in the api response.
     */
    func catchResponse(withMessage: String?) {
        DispatchQueue.main.async {
            self.view.removeSkeletonAnimation()
            if let message = withMessage, message != "" {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
