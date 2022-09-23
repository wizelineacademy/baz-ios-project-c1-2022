//
//  HomeViewController.swift
//  BAZProjectC1
//
//  Created by 1044336 on 21/09/22.
//

import UIKit

class HomeViewController: UIViewController {

    let FilterData = ["Trending","Now Playing","Popular","Top Rated","Upcoming"]
    public lazy var filterMenu: CarosuelMenu = {
        let filterMenuCGRect = CGRect(x: 0, y: 0, width: view.frame.width, height: 30)
        let filterMenu = CarosuelMenu(frame: filterMenuCGRect,
                                      optionsTitles: FilterData,
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
        carouselMovies.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        carouselMovies.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor).isActive = true
        carouselMovies.heightAnchor.constraint(equalTo: carouselMovies.widthAnchor, multiplier: view.frame.size.height / view.frame.size.width).isActive = true
        filterMenu.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        filterMenu.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 32).isActive = true
    }
    func configutionView(){
        setupUI()
        view.backgroundColor = UIColor.appColorBlack
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataInfo()
    }
    func getDataInfo() {
        ApiServiceRequest.getService(urlService: EndpointsList.movieAPI.description, structureType: MovieApiResponseModel.self, handler: {
                    [weak self] dataResponse in
                    if let data = dataResponse as? MovieApiResponseModel {
                        self?.carouselMovies.setDataInfo(infoCarousel: data.results)
                    }
                })
    }
}
