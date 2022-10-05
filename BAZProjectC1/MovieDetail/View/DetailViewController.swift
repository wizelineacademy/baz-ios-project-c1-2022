//
//  DetailViewController.swift
//  BAZProjectC1
//
//  Created by 1054812 on 22/09/22.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let movie: MovieDetail
    
    init(movie: MovieDetail) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.setupView()
        self.configureCompositionalLayout()
    }
    
    private func setupView() {
        self.collectionView.register(UINib(nibName: "DetailMovieCell", bundle: nil), forCellWithReuseIdentifier: "DetailMovieCell")
        self.collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        collectionView.register(UINib(nibName: "HeaderSection", bundle: nil), forSupplementaryViewOfKind: "Header", withReuseIdentifier: "\(HeaderSection.self)")
    }
    
    private func setupHorizontalScrollLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(120), heightDimension: .absolute(170))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: "Header", alignment: .top)]
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func setupVerticalScrollLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(700))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25)
        
        return section
    }
    
    private func configureCompositionalLayout(){
        let layout = UICollectionViewCompositionalLayout { sectionIndex, enviroment in
            switch sectionIndex {
            case 0 :
                return self.setupVerticalScrollLayout()
            default:
                return self.setupHorizontalScrollLayout()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

//MARK: Extension UITableViewDataSource
extension DetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1:
            return movie.credits.cast.count
        case 2:
            return movie.similar.results.count
        case 3:
            return movie.recommendations.results.count
        case 4:
            return movie.reviews.results.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderSection", for: indexPath) as? HeaderSection else {
            return UICollectionReusableView()
        }
        headerView.backgroundColor = UIColor.white
        
        switch indexPath.section {
        case 1:
            headerView.titleSection.text = "Créditos"
        case 2:
            headerView.titleSection.text = "Películas Similares"
        case 3:
            headerView.titleSection.text = "Películas recomendadas"
        case 4:
            headerView.titleSection.text = "Reseñas"
        default:
            headerView.titleSection.text = ""
        }
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailMovieCell", for: indexPath) as? DetailMovieCell else {
                return UICollectionViewCell()
            }
            
            cell.nameMovie.text = movie.title
            cell.averageMovie.text = String(format: "%.2f", movie.voteAverage)
            cell.overviewMovie.text = movie.overview
            cell.imgMovie.loadUrlImage(urlString: ("\(GenericApiCall.baseImageURL)\(movie.posterPath)"))
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCell else {
                return UICollectionViewCell()
            }
            switch indexPath.section {
            case 1:
                cell.setupDataCell(name: movie.credits.cast[indexPath.item].name, image: "\(GenericApiCall.baseImageURL)\(movie.credits.cast[indexPath.item].profilePath ?? "")")
                
                return cell
            case 2:
                cell.setupDataCell(name: movie.similar.results[indexPath.item].title, image: "\(GenericApiCall.baseImageURL)\(movie.similar.results[indexPath.item].posterPath)")
                
                return cell
            case 3:
                
                cell.setupDataCell(name: movie.recommendations.results[indexPath.item].title, image: "\(GenericApiCall.baseImageURL)\(movie.recommendations.results[indexPath.item].posterPath)")
                
                return cell
            case 4:
                cell.setupDataCell(name: movie.reviews.results[indexPath.item].content, image: "")
                cell.imgMovie.isHidden = true
                return cell
            default:
                return UICollectionViewCell()
                
            }
        }
    }
}
