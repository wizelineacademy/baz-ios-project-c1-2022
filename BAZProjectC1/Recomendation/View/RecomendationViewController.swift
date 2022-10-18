//
//  RecomendationViewController.swift
//  BAZProjectC1
//
//  Created by efloresco on 03/10/22.
//

import UIKit

class RecomendationViewController: UIViewController {

    @IBOutlet weak var cvMovies: UICollectionView!
    private var recomendationViewModel = RecomendationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recomendaciones"
        loadData()
        loadCell()
    }
    
    private func loadData() { 
        recomendationViewModel.bindData = {
            DispatchQueue.main.async {
                self.cvMovies.reloadData()
            }
        }
    }
    
    private func loadCell() {
        cvMovies.register(UINib(nibName: "MovieCell",bundle: nil), forCellWithReuseIdentifier: "MovieCell")
    }
}

extension RecomendationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recomendationViewModel.getNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell
        myCell?.configureCellUpdate(with: recomendationViewModel.movie(at: indexPath.row))
        return myCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.changeView(index: indexPath.row)
    }
    
    private func changeView(index: Int) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController 
        vc?.objMov = recomendationViewModel.movie(at: index)
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
}


