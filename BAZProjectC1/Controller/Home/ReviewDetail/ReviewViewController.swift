//  ReviewViewController.swift
//  BAZProjectC1
//  Created by 291732 on 04/10/22.

import UIKit

final class ReviewViewController: UIViewController {
    //MARK: - O U T L E T
    @IBOutlet weak var tblReview: UITableView!{
        didSet{
            self.tblReview.delegate = self
            self.tblReview.dataSource = self
            self.tblReview.register(ReviewTableViewCell.nib,
                                    forCellReuseIdentifier: ReviewTableViewCell.identifier)
        }
    }
    
    private var objReview: ReviewAPIResponse?
    var idMovie: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "REVIEWS"
        self.getReview(with: idMovie ?? 0)
    }
    
    //MARK: - S E R V I C E S
    private func getReview(with id: Int) {
        let movieApi = MovieAPI()
        movieApi.getReview(withId: "\(id)") { [weak self] reviewResponse, error in
            guard let self =  self else { return }
            if reviewResponse != nil {
                self.objReview = reviewResponse
                DispatchQueue.main.async {
                    self.tblReview.reloadData()
                }
            }

        }
    }

}

extension ReviewViewController: UITableViewDelegate & UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objReview?.review?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath)
        as? ReviewTableViewCell ?? ReviewTableViewCell()
        if let review = objReview?.review?[indexPath.row] {
            cell.setReview(with: review)
        }
        return cell
    }

}
