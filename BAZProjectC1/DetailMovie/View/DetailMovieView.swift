//
//  DetailMovieView.swift
//  BAZProjectC1
//
//  Created by 961184 on 26/09/22.
//  
//

import Foundation
import UIKit

class DetailMovieView: UIViewController {

    // MARK: Properties
    var presenter: DetailMoviePresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailMovieView: DetailMovieViewProtocol {
    // TODO: implement view output methods
}
