//
//  ContainerViewController.swift
//  BAZProjectC1
//
//  Created by 1054812 on 21/09/22.
//

import UIKit

final class ContainerViewController: UIViewController {
    
    private let menuVC = FilterViewController()
    private let homeVC = HomeAppViewController()
    private var navVC: UINavigationController?
    
    private enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.addChilds()
    }
    
    private func addChilds() {
        let menuNav = UINavigationController(rootViewController: menuVC)
        self.menuVC.delegate = self
        menuNav.navigationBar.barStyle = .default
        self.addChild(menuNav)
        menuNav.view.frame = self.view.frame
        self.view.addSubview(menuNav.view)
        menuNav.didMove(toParent: self)
        
        self.homeVC.delegate = self
        let homeNav = UINavigationController(rootViewController: self.homeVC)
        
        self.addChild(homeNav)
        self.view.addSubview(homeNav.view)
        homeNav.didMove(toParent: self)
        self.navVC = homeNav
    }
    
    private func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}

//MARK: HomeViewController Delegate
extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        self.toggleMenu(completion: nil)
    }
}

//MARK: Filter View Controller Delegate
extension ContainerViewController: FilterViewControllerDelegate {
    func didSelect(filter: FiltersMovies) {
        self.toggleMenu { [weak self] in
            switch filter {
            default:
                self?.homeVC.getMovies(filterSelected: filter)
            }
        }
    }
}
