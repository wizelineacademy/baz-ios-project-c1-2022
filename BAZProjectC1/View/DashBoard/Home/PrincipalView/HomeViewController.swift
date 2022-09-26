//
//  HomeViewController.swift
//  BAZProjectC1
//
//  Created by 1044336 on 21/09/22.
//

import UIKit

class HomeViewController: UIViewController {

    let filterDataArray = ["Trending","Now Playing","Popular","Top Rated","Upcoming"]
    var moviesList: [MovieModel] = [] {
        didSet{
            carouselMovies.setDataInfo(infoCarousel: moviesList)
        }
    }
    
    public lazy var filterMenu: CarosuelMenu = {
        let filterMenuCGRect = CGRect(x: 0, y: 0, width: view.frame.width, height: 30)
        let filterMenu = CarosuelMenu(frame: filterMenuCGRect,
                                      optionsTitles: filterDataArray,
                                      itemBackgroundColor: UIColor.appColorYellowPrimary,
                                      itemBorderBackgroundColor: UIColor.appColorYellowPrimary,
                                      itemSelectedBackgroundColor: UIColor.appColorWhitePrimary,
                                      itemSelectedBorderBackgroundColor: UIColor.appColorGrayPrimary)
        filterMenu.translatesAutoresizingMaskIntoConstraints = false
        filterMenu.delegate = self
        return filterMenu
    }()
    
    public lazy var carouselMovies: CarouselMovies = {
        let carouselMovies = CarouselMovies(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.height * 0.55)))
        carouselMovies.translatesAutoresizingMaskIntoConstraints = false
        carouselMovies.delegate = self
        return carouselMovies
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configutionView()
    }
    private func setupUI() {
        view.addSubview(filterMenu)
        view.addSubview(carouselMovies)
        filterMenu.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        filterMenu.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 32).isActive = true
        carouselMovies.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        carouselMovies.topAnchor.constraint(equalTo: filterMenu.layoutMarginsGuide.bottomAnchor,constant: 24).isActive = true
        carouselMovies.heightAnchor.constraint(equalTo: carouselMovies.widthAnchor, multiplier: view.frame.size.height / view.frame.size.width).isActive = true
    }
    func configutionView() {
        setupUI()
        view.backgroundColor = UIColor.appColorBlack
        //view.backgroundColor = UIColor.appColorWhitePrimary
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let firstOption = filterDataArray.first,
              let UrlOptionSelected = EndpointsList(rawValue: firstOption)?.description else { return }
        getDataInfo(urlString: UrlOptionSelected)
    }
    func getDataInfo(urlString: String) {
        ApiServiceRequest.getService(urlService: urlString, structureType: MovieApiResponseModel.self, handler: { [weak self] dataResponse in
            if let data = dataResponse as? MovieApiResponseModel {
                self?.moviesList = data.results ?? []
            }
        })
    }
}
