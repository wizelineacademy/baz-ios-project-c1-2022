//
//  BillboardViewController.swift
//  BAZProjectC1
//
//  Created by efloresco on 21/09/22.
//

import Foundation
import UIKit

class BillboardViewController : UIViewController {
    @IBOutlet weak var clvListMovies: UICollectionView!
    private var lstMovies = [MovieUpdate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.getMoviesUpdate()
    }
    
    func configureCollectionView() {
        self.title = "En cartelera"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        clvListMovies.delegate = self
        clvListMovies.dataSource = self
        clvListMovies.register(UINib(nibName: "MovieCell",bundle: nil), forCellWithReuseIdentifier: "MovieCell")
    }
    
    private func getMoviesUpdate() {
        MovieAPI().getMoviesUpdate(completion: { lstResult in
            self.lstMovies = lstResult
            DispatchQueue.main.async { [weak self] in
                self?.clvListMovies.reloadData()
            }
        })
    }
}

extension BillboardViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lstMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell
        myCell?.configureCellUpdate(with: lstMovies[indexPath.row])
        return myCell ?? UICollectionViewCell()
    }
    
}
