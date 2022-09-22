//  UpcomingViewController.swift
//  BAZProjectC1
//  Created by 291732 on 22/09/22.

import UIKit

final class UpcomingViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet weak var tblUpcoming: UITableView!{
        didSet{
            self.tblUpcoming.delegate = self
            self.tblUpcoming.dataSource = self
            self.tblUpcoming.register(UpcomingTableViewCell.nib, forCellReuseIdentifier: UpcomingTableViewCell.identifier)
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
                    self.tblUpcoming.reloadData()
                }
            }
        }
    }
}

//MARK: - EXT-> UI · T A B L E · V I E W · D E L E G A T E
extension UpcomingViewController: UITableViewDelegate & UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objUpcoming?.upcoming?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath)
        as? UpcomingTableViewCell ?? UpcomingTableViewCell()
        if let upcoming = objUpcoming?.upcoming?[indexPath.row] {
            cell.setUpcoming(with: upcoming)
        }
        return cell
    }
}
