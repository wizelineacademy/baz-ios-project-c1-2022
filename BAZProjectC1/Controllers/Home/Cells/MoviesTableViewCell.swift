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
    var listReviews: [Reviews] = [Reviews]()
    var listActors: [Actor] = [Actor]()
    private var typeCell: MoreInfoMovie?
    var containerSize: CGSize = CGSize(width: 300, height: 400)
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var constraintTitle: NSLayoutConstraint!
    @IBOutlet weak var collHome: UICollectionView! {
        didSet{
            self.collHome.register(UINib.init(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
            self.collHome.register(UINib.init(nibName: "ReviewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ReviewsCollectionViewCell")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collHome.delegate = self
        collHome.dataSource = self
    }
    
    func configCell(title: String = "", typeCell: MoreInfoMovie = .movies){
        self.typeCell = typeCell
        if title != "" {
            self.lblTitle.text = title
            constraintTitle.constant = 50
        }else{
            self.lblTitle.text = ""
            constraintTitle.constant = 0
        }
        collHome.reloadData()
    }
}

extension MoviesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch self.typeCell {
        case .movies, .recentlywatched, .similar, .recommendations:
            return listMovies.count
        case .reviews:
            return listReviews.count
        case .actors:
            return listActors.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch self.typeCell {
        case .reviews:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewsCollectionViewCell", for: indexPath as IndexPath) as! ReviewsCollectionViewCell
            if listReviews.count != 0 {
                cell.configReviews(reviews: listReviews[indexPath.row])
            }
            return cell
        case .actors:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath as IndexPath) as! MoviesCollectionViewCell
            if listActors.count != 0 {
                cell.configActor(actor: listActors[indexPath.row])
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath as IndexPath) as! MoviesCollectionViewCell
            if listMovies.count != 0 {
                cell.configMovie(movie: listMovies[indexPath.row])
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.typeCell != .reviews && self.typeCell != .actors {
            delegate?.sendDetailMovies(movie: listMovies[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return containerSize
    }
}
