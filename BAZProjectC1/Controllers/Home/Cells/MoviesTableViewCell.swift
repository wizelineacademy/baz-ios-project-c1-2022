//
//  MoviesTableViewCell.swift
//  BAZProjectC1
//
//  Created by Jacobo Diaz on 01/10/22.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    weak var delegate : ManageControllersDelegate?
    var listMovies: [Movie] = [Movie]()
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var constraintTitle: NSLayoutConstraint!
    @IBOutlet weak var collHome: UICollectionView! {
        didSet{
            self.collHome.register(UINib.init(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collHome.delegate = self
        collHome.dataSource = self
    }
    
    func configCell(listMovies: [Movie], title: String = ""){
        
        if title != "" {
            self.lblTitle.text = title
            constraintTitle.constant = 50
        }else{
            self.lblTitle.text = ""
            constraintTitle.constant = 0
        }
        
        self.listMovies = listMovies
        collHome.reloadData()
        let indexPath = IndexPath(item: 0 , section: 0)
        collHome.selectItem(at: indexPath, animated: true, scrollPosition: .left)
    }
}

extension MoviesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listMovies.count == 0 {
            return 2
        }else{
            return listMovies.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath as IndexPath) as! MoviesCollectionViewCell
        if listMovies.count != 0 {
            cell.configMovie(movie: listMovies[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.sendDetailMovies(movie: listMovies[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 400)
    }
}
