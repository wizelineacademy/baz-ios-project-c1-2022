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
    private var vmBilboard = BilboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.getMoviesUpdate()
    }
    
    private func configureCollectionView() {
        self.title = "En cartelera"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        clvListMovies.delegate = self
        clvListMovies.dataSource = self 
        clvListMovies.register(UINib(nibName: "MovieCell",bundle: nil), forCellWithReuseIdentifier: "MovieCell")
    }
    
    private func getMoviesUpdate() {
        vmBilboard.bindData = {
            DispatchQueue.main.async {
                self.clvListMovies.reloadData()
            }
        }
    }
}

extension BillboardViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vmBilboard.getNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell
        myCell?.configureCellUpdate(with: vmBilboard.movie(at: indexPath.row))
        return myCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
}
