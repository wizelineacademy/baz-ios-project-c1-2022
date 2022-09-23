//  CustomTabBarController.swift
//  BAZProjectC1
//  Created by 291732 on 21/09/22.

import UIKit

class CustomTabBarController: UITabBarController {
    
    let wzlnRed: UIColor = UIColor(red: 117/255, green: 31/255, blue: 34/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = wzlnRed
        UITabBar.appearance().barTintColor = wzlnRed
        tabBar.backgroundColor = wzlnRed
        tabBar.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpViewControllers()
    }
    
    func setUpViewControllers(){
        viewControllers=[
            createNavController(for:TrendingViewController(),
                                   title:NSLocalizedString("Trending", comment: ""),
                                   image:UIImage(systemName: "sparkles.tv") ?? UIImage()),
            createNavController(for:NowPlayingViewController(),
                                   title:NSLocalizedString("Now Playing", comment: ""),
                                   image:UIImage(systemName: "play.square") ?? UIImage()),
            createNavController(for:PopularViewController(),
                                   title:NSLocalizedString("Popular", comment: ""),
                                   image:UIImage(systemName: "sparkle.magnifyingglass") ?? UIImage()),
            createNavController(for:TopRatedViewController(),
                                   title:NSLocalizedString("Top Rated", comment: ""),
                                   image:UIImage(systemName: "chart.xyaxis.line") ?? UIImage()),
            createNavController(for:UpcomingViewController(),
                                   title:NSLocalizedString("Upcoming", comment: ""),
                                   image:UIImage(systemName: "deskclock") ?? UIImage())
        ]
    }
    
    
    fileprivate func createNavController(for rootVC: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootVC )
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.titleTextAttributes = [.foregroundColor: wzlnRed]
//        navController.navigationBar.backgroundColor = wzlnRed
        rootVC.navigationItem.title = title
        return navController
    }
}
