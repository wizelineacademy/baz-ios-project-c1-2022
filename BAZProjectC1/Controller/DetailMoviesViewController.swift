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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
