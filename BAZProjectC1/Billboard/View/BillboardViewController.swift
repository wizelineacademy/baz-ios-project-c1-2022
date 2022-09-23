//
//  BillboardViewController.swift
//  BAZProjectC1
//
//  Created by efloresco on 21/09/22.
//

import Foundation
import UIKit

class BillboardViewController : UIViewController {
    @IBOutlet weak var clvListMovies: UICollectionView!
    var lstMovies = [Movie]()
    let columnNum: CGFloat = 3
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clvListMovies.delegate = self
        clvListMovies.dataSource = self
        clvListMovies.register(UINib(nibName: "MovieCell",bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        
        MovieAPI().getMoviesUpdate(completion: { lstResult in
            self.lstMovies = lstResult
            DispatchQueue.main.async { [weak self] in
                self?.clvListMovies.reloadData()
            }
        })
        
        self.title = "En cartelera"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
extension BillboardViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lstMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell
        myCell?.configureCellWithUrl(movieInfo: lstMovies[indexPath.row])
        return myCell ?? UICollectionViewCell()
    }
    
}
extension BillboardViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
      let availableWidth = view.frame.width - paddingSpace
      let widthPerItem = availableWidth / itemsPerRow
      
      return CGSize(width: widthPerItem, height: widthPerItem)
    }
     
    func collectionView(
      _ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      insetForSectionAt section: Int
    ) -> UIEdgeInsets {
      return sectionInsets
    }
    
    func collectionView(
      _ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
      return sectionInsets.left
    }
  }
