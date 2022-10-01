//
//  DetailMovieViewController.swift
//  BAZProjectC1
//
//  Created by Fernando Garcia Hernandez on 27/09/22.
//

import UIKit


class DetailMovieViewController: UIViewController {
    
    var detailMovie: PosterCollectionCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
//        self.view.backgroundColor = .darkGray
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.view.showAnimation()
    }
    
    func setupView(){
        print("Se muestra el detalle de la pelicula")
//        print("\(detailMovie?.title)")
    }
}
