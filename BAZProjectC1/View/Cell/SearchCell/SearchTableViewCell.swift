//  SeachTableViewCell.swift
//  BAZProjectC1
//  Created by 291732 on 28/09/22.

import UIKit

final class SearchTableViewCell: UITableViewCell {
    //MARK: - O U T L E T S
    @IBOutlet private weak var vwContainer: UIView!
    @IBOutlet private weak var cvCollectionContainer: UICollectionView!{
        didSet{
            self.cvCollectionContainer.delegate = self
            self.cvCollectionContainer.dataSource = self
            self.cvCollectionContainer.register(UINib(nibName: "ElementCollectionViewCell", bundle: .main),
                                                 forCellWithReuseIdentifier: ElementCollectionViewCell.identifier)
        }
    }
    
    //MARK: -  V A R I A B L E S
    static var nib: UINib { return UINib(nibName: identifier, bundle: .main ) }
    var dctDataSource: [String:Any]?
    private var objMovie: MovieAPIResponse?
    private var objNowPlay: NowPlayingAPIResponse?
    private var objPupular: PopularAPIResponse?
    private var objTopRated: TopRatedAPIResponse?
    private var objUpcoming: UpcomingAPIResponse?


    override func awakeFromNib() {
        super.awakeFromNib()
        self.coordinateData(from: dctDataSource ?? [String:Any]())
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func coordinateData(from: [String:Any] ){
        self.objMovie = from["trendind"] as? MovieAPIResponse
    }
    
}

extension SearchTableViewCell: UICollectionViewDelegate & UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cCell = collectionView.dequeueReusableCell(withReuseIdentifier: ElementCollectionViewCell.identifier, for: indexPath) as? ElementCollectionViewCell ?? ElementCollectionViewCell()
        return cCell
    }

}
