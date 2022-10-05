//
//  TabBarMenu.swift
//  BAZProjectC1
//
//  Created by 1044336 on 21/09/22.
//

import UIKit

class TabBarMenu: UITabBarController {

    private var optionsMenu:[String] = ["Home", "Search"] {
        didSet{
            initOpcionsMenu()
        }
    }
    
    private var optionColor: UIColor = UIColor.appColorGraySecondary {
        didSet{
            initOpcionsMenu()
        }
    }
    
    private var selectionColor: UIColor = UIColor.appColorYellowPrimary {
        didSet{
            initOpcionsMenu()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateElement()
        initOpcionsMenu()
    }
    
    func configurateElement() {
        tabBar.backgroundColor = UIColor.appColorGrayPrimary
        if #available(iOS 13, *) {
            let appearance = UITabBarAppearance()
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: optionColor]
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: selectionColor]
            tabBar.standardAppearance = appearance
        }
        let backgroundSize = CGSize(width: tabBar.frame.width / CGFloat(tabBar.items!.count), height: tabBar.frame.height)
        tabBar.selectionIndicatorImage = UIImage.imageFromColor(with: UIColor.clear, size: backgroundSize)
    }
    
    func initOpcionsMenu() {
        var viewsControllesList:[UIViewController] = []
        if (UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController)?.canResignFirstResponder ?? false {
            print("Error Load HomeViewController")
        }
        optionsMenu.forEach({ viewController in
            let controller = (UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "\(viewController)ViewController"))
            controller.tabBarItem = UITabBarItem(title : "\(viewController)",
                                                 image : UIImage(named: "\(viewController)")?.withTintColor(optionColor).withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                                 selectedImage: UIImage(named: "\(viewController)")?.withTintColor(selectionColor).withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
            viewsControllesList.append(controller)
        })
        viewControllers = viewsControllesList
    }
}
