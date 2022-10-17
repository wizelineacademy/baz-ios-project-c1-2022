//  CustomTabBarController.swift
//  BAZProjectC1
//  Created by 291732 on 21/09/22.

import UIKit

final class CustomTabBarController: UITabBarController {
    /// Creamos una variable de tipo color, para usarlo en la apariencia del tapBar
    let wizelineRed: UIColor = UIColor(red: 117/255, green: 31/255, blue: 34/255, alpha: 1)
    
    
    //MARK: - F U N C T I O N S
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = wizelineRed
        UITabBar.appearance().barTintColor = wizelineRed
        tabBar.backgroundColor = wizelineRed
        tabBar.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpViewControllers()
    }
    
    /// Esta funcion nos permite asignar las vistas que va a mostrar el tapBar, con la funcion createNavController
    func setUpViewControllers(){
        viewControllers = [
            createNavController(for:HomeViewController(),
                                   title:NSLocalizedString("Home", comment: ""),
                                   image:UIImage(systemName: "magnifyingglass.circle") ?? UIImage()),
            createNavController(for:MovieCategoryTableViewController(movieCategory: .trending),
                                   title:NSLocalizedString("Trending", comment: ""),
                                   image:UIImage(systemName: "sparkles.tv") ?? UIImage()),
            createNavController(for:MovieCategoryTableViewController(movieCategory: .nowPlaying),
                                   title:NSLocalizedString("Now Playing", comment: ""),
                                   image:UIImage(systemName: "play.square") ?? UIImage()),
            createNavController(for:MovieCategoryTableViewController(movieCategory: .popular),
                                   title:NSLocalizedString("Popular", comment: ""),
                                   image:UIImage(systemName: "sparkle.magnifyingglass") ?? UIImage()),
            createNavController(for:MovieCategoryTableViewController(movieCategory: .topRated),
                                   title:NSLocalizedString("Top Rated", comment: ""),
                                   image:UIImage(systemName: "chart.xyaxis.line") ?? UIImage()),
            createNavController(for:UpcomingViewController(),
                                   title:NSLocalizedString("Upcoming", comment: ""),
                                   image:UIImage(systemName: "deskclock") ?? UIImage())
        ]
    }

    /// Esta funcion nos devuelve un UIViewController el cual va a poder ser navegable en el TapBat
    /// - Parameters:
    ///   - rootVC: Esta vista es la que va a contener al tapBar
    ///   - title: Titulo que va a tener el elemento en el tapBar
    ///   - image: Una imagen para pintar en el tapBar
    /// - Returns: Un viewController listo para ser consultado en el TapBar
    fileprivate func createNavController(for rootVC: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootVC )
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.titleTextAttributes = [.foregroundColor: wizelineRed]
        rootVC.navigationItem.title = title
        return navController
    }
}
