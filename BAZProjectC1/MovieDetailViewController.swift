//
//  MovieDetailViewController.swift
//  BAZProjectC1
//
//  Created by 961184 on 23/09/22.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var imgMovie: CachedImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var txvOverview: UITextView!
    
    private let urlBase = "https://image.tmdb.org/t/p/w500"
    var strTitle:String?
    var strDetails:String?
    var strOverview:String?
    var strImgMoviePath:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTitle.text = self.strTitle
        self.lblDetails.text = self.strDetails
        self.txvOverview.text = self.strOverview
        self.imgMovie.loadImage(urlStr: "\(urlBase)\(strImgMoviePath ?? "")")
    }

}
