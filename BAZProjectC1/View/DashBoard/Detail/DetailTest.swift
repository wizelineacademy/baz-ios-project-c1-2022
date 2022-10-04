//
//  DetailTest.swift
//  BAZProjectC1
//
//  Created by 1044336 on 04/10/22.
//
import UIKit

class DetailTest: UIViewController {
    
    private var elementData: MovieModel?
    
    @IBOutlet weak var posterImage: movieImageView!
    @IBOutlet weak var scrollArea: UIScrollView!
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var nameElement: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpView()
    }
    
    func setUpView() {
        reloadDataInView()
        loadedAnimation()
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
        self.dismiss(animated: true, completion: nil)
    }
    private func reloadDataInView() {
        view.backgroundColor = UIColor.appColorBlack
        ContentView.addSubview(nameElement)
        ContentView.backgroundColor = UIColor.appColorBlack
        posterImage.loadImage(with: elementData?.getMoviePosterString() ?? "")
        nameElement.text = elementData?.getMovieTitleString()
        nameElement.textColor = UIColor.appColorWhitePrimary
    }
    
}
