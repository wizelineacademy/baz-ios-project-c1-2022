//
//  MovieMainListViewController.swift
//  BAZProjectC1
//
//  Created by 1030361 on 22/09/22.
//

import UIKit

class MovieMainListViewController: UIViewController {

    var myData = ["1","2","3"]
    @IBOutlet weak var collectionView: MovieMainListCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
