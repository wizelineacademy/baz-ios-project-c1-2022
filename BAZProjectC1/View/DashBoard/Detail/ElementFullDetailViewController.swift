//
//  ElementFullDetailViewController.swift
//  BAZProjectC1
//
//  Created by 1044336 on 04/10/22.
//

import UIKit

class ElementFullDetailViewController: UIViewController {
    
    private var elementData: MovieModel?
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
        movieImage.loadImage(with: elementData?.posterPath ?? "")
        genreList.backgroundColor = UIColor.clear
        let modelConfiguration = CarosuelMenuConfiguration(frame: .zero,
                                                           optionsTitles: elementData?.getGenresArray() ?? [] ,
                                                           itemBackgroundColor: UIColor.appColorYellowPrimary,
                                                           itemBorderBackgroundColor: UIColor.appColorYellowPrimary,
                                                           itemSelectedBackgroundColor: UIColor.appColorYellowPrimary,
                                                           itemSelectedBorderBackgroundColor: UIColor.appColorYellowPrimary)
        genreList.configure(with: modelConfiguration)
    }
    
    func loadedAnimation() {
        view.transform = CGAffineTransform(scaleX: 0.00001, y: 0.00001)
        UIView.animate(withDuration: 1.25, animations: { [weak self] in
            self?.view.transform = CGAffineTransform.identity
        })
    }
    
    func setElementData(with elementData: MovieModel?) {
        self.elementData = elementData
    }
    
    @IBAction func goBack(_ sender: backButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
