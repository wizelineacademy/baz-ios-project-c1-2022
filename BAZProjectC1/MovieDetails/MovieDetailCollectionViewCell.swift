//
//  MovieDetailCollectionViewCell.swift
//  BAZProjectC1
//
//  Created by 1030361 on 03/10/22.
//

import UIKit

internal final class MovieDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tableView: UITableView!
    
    var movieReviews: [MovieReviews]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ReviewsTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewsTableViewCell")
    }

}

extension MovieDetailCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieReviews?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reviewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ReviewsTableViewCell", for: indexPath) as? ReviewsTableViewCell else { return UITableViewCell() }
        reviewsTableViewCell.lblAuthor.text = movieReviews?[indexPath.row].author
        reviewsTableViewCell.lblReview.text = movieReviews?[indexPath.row].content
        reviewsTableViewCell.selectionStyle = .none
        return reviewsTableViewCell
    }

    
}
