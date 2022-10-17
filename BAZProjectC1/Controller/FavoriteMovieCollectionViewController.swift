//
//  FavoriteMovieCollection.swift
//  BAZProjectC1
//
//  Created by rnunezi on 15/10/22.
//

import UIKit

//MARK: - FavoriteMovieCollectionProtocol

protocol FavoriteMovieCollectionProtocol{
    
    func addFavoriteMovies(_ detailMovie: DetailMovie?)
    func removeFavoriteMovies(_ detailMovie: DetailMovie?)
}

//MARK: - FavoriteMovieCollectionViewController

class FavoriteMovieCollectionViewController: MovieCollectionViewController{
    
    override func viewDidAppear(_ animated: Bool){
        
        self.title = ConstantsDetailMovies.titleFavoriteCollection
        isMovieOriginal = false
        setDataCollection()
    }
    
    override func viewDidLoad() {
        
        setConfigurationFavoriteMovies()
    }
    
    //  Method:  Favorite movies settings
    private func setConfigurationFavoriteMovies(){
        
        NotificationCenter.default.post(name: Notification.Name("colorChanged"),object:nil)
        view.backgroundColor = .cyan
        searchBar.delegate = self
        collectionMovieC.register(UINib(nibName: "MovieCollectionViewCell", bundle: Bundle(for: MovieCollectionViewCell.self)), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        delegateMovies = self
    }
}
