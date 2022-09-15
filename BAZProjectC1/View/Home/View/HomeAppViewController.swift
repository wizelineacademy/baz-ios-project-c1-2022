//
//  HomeAppViewController.swift
//  BAZProjectC1
//
//  Created 1054812 on 14/09/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class HomeAppViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    init() {
        super.init(nibName: "HomeAppViewController", bundle: Bundle(for: HomeAppViewController.self))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var movies: [Movie] = []
    let movieApi = MovieAPI()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Trending"
        
        self.movieApi.getMovies { movies in
            self.movies = movies
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        self.configureCollectionView()
    }
 
    func configureCollectionView(){
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "movieCell")
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width:(width - 40)  / 2, height: 220)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        self.collectionView.collectionViewLayout = layout
    }
    
}


// MARK:  - Extension CollectionViewDataSource.
extension HomeAppViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let infoMovie : Movie!
        infoMovie = self.movies[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        cell.nameMovie.text = infoMovie.title
        
        let baseImageURL = "https://image.tmdb.org/t/p/w500/"
        cell.imgMovie.loadUrlImage(urlString: (baseImageURL + infoMovie.poster_path))
        return cell
    }
}
