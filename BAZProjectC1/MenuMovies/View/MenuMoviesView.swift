//
//  MenuMoviesView.swift
//  BAZProjectC1
//
//  Created by 961184 on 26/09/22.
//  
//

import Foundation
import UIKit

class MenuMoviesView: UIViewController {

    // MARK: Properties
    var presenter: MenuMoviesPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MenuMoviesView: MenuMoviesViewProtocol {
    // TODO: implement view output methods
}
