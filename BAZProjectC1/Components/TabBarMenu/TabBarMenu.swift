//
//  TabBarMenu.swift
//  BAZProjectC1
//
//  Created by 1044336 on 21/09/22.
//

import UIKit

class TabBarMenu: UITabBarController {

    private var optionsMenu:[String] = ["Home","Search"] {
        didSet{
            initOpcionsMenu()
        }
    }
    private var optionColor: UIColor = UIColor.systemGray {
        didSet{
            initOpcionsMenu()
        }
    }
    private var selectionColor: UIColor = UIColor.systemBlue {
        didSet{
            initOpcionsMenu()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateElement()
        initOpcionsMenu()
    }
    func configurateElement(){
        tabBar.backgroundColor = UIColor.white
    }
    func initOpcionsMenu(){
        var viewsControllesList:[UIViewController] = []
        
        if (UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController)?.canResignFirstResponder ?? false {
            print("Error Load HomeViewController")
        }
        optionsMenu.forEach({ viewController in

            let controller = (UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "\(viewController)ViewController"))
            controller.tabBarItem = UITabBarItem(title : "\(viewController)",
                                                 image : UIImage(named: "\(viewController)")?.withTintColor(optionColor),
                                                 selectedImage: UIImage(named: "\(viewController)")?.withTintColor(selectionColor).withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
            controller.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: optionColor], for: .normal)
            controller.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectionColor], for: .selected)
            viewsControllesList.append(controller)
        })
        viewControllers = viewsControllesList
    }
    

}
