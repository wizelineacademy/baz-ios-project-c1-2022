//
//  DetailViewController.swift
//  BAZProjectC1
//
//  Created by efloresco on 21/09/22.
//

import Foundation
import UIKit

class DetailViewController : UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgDetail: UIImageView!
    var objMov: MovieUpdate? = nil
    @IBOutlet weak var txvDetail: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        loadImage()
        
    }
    
    private func configureViewController() {
        self.title = "Pelicula"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil) 
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Buscar", style: .plain, target: self, action: #selector(navigateToSearchMovieViewController))
    }
    
    private func loadImage() {
        lblTitle.text = objMov?.title
        lblTitle.loadConfigurationFont(with: true)
        if let urlImage = objMov?.imageDetail {
            imgDetail.loadFrom(strUrl: "\(urlImage)")
        } else {
            imgDetail.image = UIImage.init(named: "placeHolder")
        }
        txvDetail.text = objMov?.overview ?? "No existe descripcion de la pelicula que ingresaste"
        txvDetail.loadConfigurationFont()
    }
    
    @objc private func navigateToSearchMovieViewController() {
        let vc = SearchViewController.init(nibName: "SearchViewController", bundle: nil)
        vc.delegateSearch = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension DetailViewController: SearchMovieImp {
    func selectOptions(with movie: MovieUpdate) {
        objMov = movie
        loadImage()
    }
}
