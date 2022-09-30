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
    @IBOutlet weak var imgPoster: UIImageView!
    var strTitle:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = strTitle
        
    }

}
