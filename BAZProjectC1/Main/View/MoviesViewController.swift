//
//  MoviesViewController.swift
//  BAZProjectC1
//
//  Created by Fernando Garcia Hernandez on 22/09/22.
//

import UIKit
import Foundation

class MoviesViewController: UIViewController {
    var postersMovieArray = MovieModel()
    var tappedCell: PosterCollectionCell!
    @IBOutlet weak var TableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        self.TableView.register(UINib.init(nibName: "TableViewCell", bundle: Bundle(for: TableViewCell.self)), forCellReuseIdentifier: "cell")
    }
    
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postersMovieArray.movieObject[section].posters.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        let rowArray = postersMovieArray.movieObject[indexPath.section].posters[indexPath.row]
        cell.updateCellWith(row: rowArray)
        
        //MARK: - Cell delegation
        cell.cellDelegate = self
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return postersMovieArray.movieObject.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.darkGray
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 0, width: 200, height: 44))
        headerView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.text = postersMovieArray.movieObject[section].sectionFilter
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

extension MoviesViewController: CollectionViewCellDelegate {
    func collectionView(collectionviewcell: CollectionViewCell?, index: Int, didTappedInTableViewCell: TableViewCell) {
        if let posterRow = didTappedInTableViewCell.rowWithPosters {
            debugPrint(posterRow[index])
            self.tappedCell = posterRow[index]
            // TODO: - Send to other screen
        }
    }
}
