//
//  HomeViewController.swift
//  BAZProjectC1
//
//  Created by 1044336 on 21/09/22.
//

import UIKit

class HomeViewController: UIViewController {

    public lazy var carouselMovies: CarouselMovies = {
        let carouselMovies = CarouselMovies(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.height * 0.50)))
        carouselMovies.translatesAutoresizingMaskIntoConstraints = false
        carouselMovies.delegate = self
        return carouselMovies
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configutionView()
    }
    private func setupUI() {
        view.addSubview(carouselMovies)
        NSLayoutConstraint.activate([carouselMovies.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
                                     carouselMovies.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,constant: 32),
                                     carouselMovies.heightAnchor.constraint(equalTo: carouselMovies.widthAnchor, multiplier: view.frame.size.height / view.frame.size.width)])
    }
    func configutionView(){
        setupUI()
        view.backgroundColor = UIColor.systemBlue
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
