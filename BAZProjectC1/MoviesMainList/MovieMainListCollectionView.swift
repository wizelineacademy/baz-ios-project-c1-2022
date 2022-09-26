//
//  MovieMainListCollectionView.swift
//  BAZProjectC1
//
//  Created by 1030361 on 22/09/22.
//

import UIKit
//
//class MovieMainListCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    private var labels = ["A", "B", "C", "D", "E", "F", "G", "H", "I"]
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieMainListCollectionViewCell.identifier, for: indexPath as IndexPath) as! MovieMainListCollectionViewCell
//        cell.setLabel(text: labels[indexPath.row])
//
//        return cell
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self.dataSource = self
//        self.delegate = self
//        self.register(MovieMainListCollectionViewCell.self, forCellWithReuseIdentifier: MovieMainListCollectionViewCell.identifier)
////        self.register(MovieMainListCollectionViewCell.self, forCellWithReuseIdentifier: "MovieMainListCollectionViewCell")
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        numberOfItemsInSection section: Int) -> Int {
//        return labels.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//        return CGSize(width: 100, height: 100)
//    }
//}
