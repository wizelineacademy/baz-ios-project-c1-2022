//  TopRatedViewController.swift
//  BAZProjectC1
//  Created by 291732 on 21/09/22.

import UIKit

final class TopRatedViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet weak var tblTopRated: UITableView!{
        didSet {
            self.tblTopRated.delegate = self
            self.tblTopRated.dataSource = self
            self.tblTopRated.register(TopRatedTableViewCell.nib,
                                      forCellReuseIdentifier: TopRatedTableViewCell.identifier)
        }
    }
    
    //MARK: - V A R I A B L E S
    private var objTopRated: TopRatedAPIResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Rated"
        self.getTopRated()
    }
    
    //MARK: - S E R V I C E S
    private func getTopRated(){
        let movie_WS = MovieAPI()
        movie_WS.getTopRated { [weak self] topRatedResponse, error in
            guard let self = self else{ return }
            if topRatedResponse != nil {
                self.objTopRated = topRatedResponse
                DispatchQueue.main.async {
                    self.tblTopRated.reloadData()
                }
            }
        }
    }
}

//MARK: - EXT-> UI · T A B L E · V I E W · D E L E G A T E
extension TopRatedViewController: UITableViewDelegate & UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objTopRated?.topRateds?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopRatedTableViewCell.identifier, for: indexPath) as? TopRatedTableViewCell ?? TopRatedTableViewCell()
        if let topRated = objTopRated?.topRateds?[indexPath.row]{
            cell.setTopRated(with: topRated)
        }
        return cell
    }
}
