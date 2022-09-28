//
//  SearchMovieViewController.swift
//  BAZProjectC1
//
//  Created by 1029186 on 22/09/22.
//

import UIKit

class SearchMovieViewController: UIViewController {


    @IBOutlet weak var searchTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.addTarget(self, action: #selector(searchMovie), for: .editingChanged)
    }

    @objc
    private func searchMovie() {
        return
    }
}
