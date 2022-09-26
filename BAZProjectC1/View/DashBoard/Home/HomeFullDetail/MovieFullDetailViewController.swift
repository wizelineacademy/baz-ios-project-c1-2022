//
//  MovieFullDetailViewController.swift
//  BAZProjectC1
//
//  Created by 1044336 on 26/09/22.
//

import UIKit

class MovieFullDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hola")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.transform = CGAffineTransform(scaleX: 0.00001, y: 0.00001)
        UIView.animate(withDuration: 0.75, animations: { [weak self] in
            self?.view.transform = CGAffineTransform.identity})
    }
}
