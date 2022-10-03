//  UpcomingViewController.swift
//  BAZProjectC1
//  Created by 291732 on 22/09/22.

import UIKit

final class UpcomingViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet private weak var cvUpcoming: UICollectionView!{
        didSet{
            self.cvUpcoming.delegate = self
            self.cvUpcoming.dataSource = self
            self.cvUpcoming.register(UINib(nibName: "UpcomingCollectionViewCell",
                                             bundle: .main),
                                       forCellWithReuseIdentifier: UpcomingCollectionViewCell.identifier)
        }
    }
    
    //MARK: - V A R I A B L E S
    private var objUpcoming: UpcomingAPIResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Upcoming"
        self.getUpcoming()
    }
    
    //MARK: - S E R V I C E S
    private func getUpcoming(){
        let movie_WS = MovieAPI()
        movie_WS.getUpcomgin { [weak self] upcomingResponse, error in
            guard let self = self else{ return }
            if upcomingResponse != nil {
                self.objUpcoming = upcomingResponse
                DispatchQueue.main.async {
                    self.cvUpcoming.reloadData()
                }
            }
        }
    }
}


//MARK: - EXT-> UI · C O L L E C T I O N · V I E W · D E L E G A T E
extension UpcomingViewController: UICollectionViewDelegate & UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objUpcoming?.upcoming?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cCell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCollectionViewCell.identifier,
                                                       for: indexPath) as? UpcomingCollectionViewCell ?? UpcomingCollectionViewCell()
        if let upcoming = objUpcoming?.upcoming?[indexPath.row] {
            cCell.setCell(with: upcoming)
        }
        return cCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let upcomingDetail = UpcomingDetailViewController()
        upcomingDetail.index = indexPath.row
        upcomingDetail.objUpcoming = objUpcoming
        self.navigationController?.pushViewController(upcomingDetail, animated: true)
    }
}


//MARK: - EXT-> UI · C O L L E C T I O N · D E L E G A T E · F L O W · L A Y O U T
extension UpcomingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2 , height: 240)
    }
}
