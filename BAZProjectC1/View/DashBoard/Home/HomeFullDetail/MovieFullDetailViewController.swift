//
//  MovieFullDetailViewController.swift
//  BAZProjectC1
//
//  Created by 1044336 on 26/09/22.
//

import UIKit

class MovieFullDetailViewController: UIViewController {
    
    var item: MovieModel?
    
    @IBOutlet weak var movieImage: movieImageView!
    @IBOutlet weak var genreList: CarosuelMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpView()
    }
    
    func setUpView() {
        view.backgroundColor = UIColor.appColorBlack
        loadedAnimation()
        movieImage.loadImage(with: item?.posterPath ?? "")
        genreList.backgroundColor = UIColor.clear
        genreList.configure(optionsTitles: item?.getGenresArray() ?? [],
                            itemBackgroundColor: UIColor.appColorYellowPrimary,
                            itemBorderBackgroundColor: UIColor.appColorYellowPrimary,
                            itemSelectedBackgroundColor: UIColor.appColorYellowPrimary,
                            itemSelectedBorderBackgroundColor: UIColor.appColorYellowPrimary)
    }
    
    func loadedAnimation() {
        view.transform = CGAffineTransform(scaleX: 0.00001, y: 0.00001)
        UIView.animate(withDuration: 1.25, animations: { [weak self] in
            self?.view.transform = CGAffineTransform.identity
        })
    }
    
    @IBAction func butAtion(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
