//
//  CollectionViewCast.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 02/10/22.
//

import UIKit

final class CollectionViewCast: UICollectionViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private let cellIdentifier = "CreditsMovie"
    private var actorsCast = MovieCast(cast: [Cast]())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    public func loadData(actorsMovie: MovieCast) {
        self.actorsCast = actorsMovie
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension CollectionViewCast: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CreditsMovie else { return UICollectionViewCell() }
        if let actor = actorsCast.cast[indexPath.row].name, let imageActor = actorsCast.cast[indexPath.row].profilePath{
            cell.actorName.text = actor
            cell.actorImage.downloaded(from: "https://image.tmdb.org/t/p/w500\(String(describing: imageActor))")
        }
        return cell
    }
}


extension CollectionViewCast: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(150), height: CGFloat(300))
    }
}

