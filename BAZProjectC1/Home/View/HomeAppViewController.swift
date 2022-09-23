//
//  HomeAppViewController.swift
//  BAZProjectC1
//
//  Created 1054812 on 14/09/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

final class HomeAppViewController: UIViewController {
    
    @IBOutlet weak private var collectionView: UICollectionView!
    
    weak var delegate: HomeViewControllerDelegate?
    
   private var movies: [Movie] = []
   private let movieApi = MovieAPI()
   private var leftBarButton: UIBarButtonItem!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureCollectionView()
       
        self.leftBarButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(self.showMenu(_:)))
        self.leftBarButton.tintColor = .black
        self.navigationItem.leftBarButtonItem  = leftBarButton

        self.getMovies(filterSelected: .trending)
    }
    
    public func getMovies(filterSelected: FiltersMovies) {
        self.title = filterSelected.title
        self.movieApi.getMovies(url: filterSelected.url) { movies in
            self.movies = movies
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func configureCollectionView(){
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
    
    @objc func showMenu(_ sender: UIBarButtonItem) {
        self.delegate?.didTapMenuButton()
    }
}


// MARK:  - Extension CollectionViewDataSource.
extension HomeAppViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCell
        else {
            return UICollectionViewCell()
        }
        cell.nameMovie.text = self.movies[indexPath.row].title
        let baseImageURL = "https://image.tmdb.org/t/p/w500/"
        cell.imgMovie.loadUrlImage(urlString: (baseImageURL + self.movies[indexPath.row].posterPath))
        return cell
    }
}

extension HomeAppViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.movie = self.movies[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
