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

//extension MovieMainListViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        myData.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieMainListCollectionViewCell.identifier, for: indexPath) as! MovieMainListCollectionViewCell
//        // return card
//        return cell
//    }
//}
//
//extension MovieMainListViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        // add the code here to perform action on the cell
//        let cell = collectionView.cellForItem(at: indexPath) as? MovieMainListCollectionViewCell
//    }
//}
