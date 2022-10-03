//
//  NowViewController.swift
//  BAZProjectC1
//
//  Created by efloresco on 03/10/22.
//

import UIKit

class NowViewController: UIViewController {

    var lstMovies: [MovieUpdate] = []
    @IBOutlet weak var cvMovies: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Actualmente"
        loadControl()
        let movieApi = MovieAPI()
        movieApi.getNowPlaying()
        NotificationCenter.default.addObserver(self, selector: #selector(loadData(notification:)), name: Notification.Name("notificationNowPlay"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func loadData(notification: Notification) {
        guard let lst = (notification.object as? [String: Any])?["infoData"] as? [MovieUpdate] else {
            return
        }
        self.lstMovies = lst
        DispatchQueue.main.async {
            self.cvMovies.reloadData()
        }
    }
    
    func loadControl() {
        cvMovies.register(UINib(nibName: "MovieCell",bundle: nil), forCellWithReuseIdentifier: "MovieCell")
    }
    
}

extension NowViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lstMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell
        myCell?.configureCellUpdate(with: lstMovies[indexPath.row])
        return myCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.changeView(iIndex: indexPath.row)
    }
    func changeView(iIndex: Int) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.objMov = lstMovies[iIndex]
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
}
