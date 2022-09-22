//  CustomTabBarController.swift
//  BAZProjectC1
//  Created by 291732 on 21/09/22.

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 117/255, green: 31/255, blue: 34/255, alpha: 1)
        UITabBar.appearance().barTintColor = .white
        tabBar.tintColor = .white
        tabBar.backgroundColor = UIColor(red: 117/255, green: 31/255, blue: 34/255, alpha: 1)
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
        navController.navigationBar.prefersLargeTitles=true
        rootVC.navigationItem.title = title
        return navController
    }
    
}

extension CustomTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
    
}

