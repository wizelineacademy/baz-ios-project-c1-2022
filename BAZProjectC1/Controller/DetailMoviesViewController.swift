//
//  DetailMoviesViewController.swift
//  BAZProjectC1
//
//  Created by rnunezi on 28/09/22.
//

import UIKit

class DetailMoviesViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgPoster: ImageView!
    private let urlBaseImg = "https://image.tmdb.org/t/p/w500"
    var strTitle:String = ""
    var strDetails:String = ""
    var strImgMoviePath:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTitle.text = self.strTitle
        self.lblDescription.text = self.strDetails
        self.imgPoster.loadImage(urlStr: "\(urlBaseImg)\(strImgMoviePath )")
    }

}
