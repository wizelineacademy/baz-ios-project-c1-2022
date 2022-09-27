//
//  TableViewCell.swift
//  BAZProjectC1
//
//  Created by Fernando Garcia Hernandez on 22/09/22.
//

import UIKit

protocol CollectionViewCellDelegate: AnyObject {
    func collectionView(collectionviewcell: CollectionViewCell?, index: Int, didTappedInTableViewCell: TableViewCell)
}


class TableViewCell: UITableViewCell {
   
    weak var cellDelegate: CollectionViewCellDelegate?
    
    var rowWithPosters: [PosterCollectionCell]?

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 150, height: 180)
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 5.0
        
        //Setup collection
        self.categoryCollectionView.collectionViewLayout = flowLayout
        self.categoryCollectionView.showsHorizontalScrollIndicator = false
        
        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.delegate = self
        
        // Register the xib
        let cellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.categoryCollectionView.register(cellNib, forCellWithReuseIdentifier: "collectionviewcellid")
    }
    
}



extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func updateCellWith(row: [PosterCollectionCell]) {
        self.rowWithPosters = row
        self.categoryCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        debugPrint("Seleccionado \(indexPath.item)")
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rowWithPosters?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcellid", for: indexPath) as? CollectionViewCell {
            cell.movieLabel.text = self.rowWithPosters?[indexPath.item].title ?? ""
            let urlEndPoint = self.rowWithPosters?[indexPath.item].posterImage ?? ""
            
            cell.setImage(urlEndpoint: urlEndPoint) //set Image async
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    // Add spaces between collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
