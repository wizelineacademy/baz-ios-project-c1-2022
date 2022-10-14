//
//  UpcomingViewController.swift
//  BAZProjectC1
//
//  Created by efloresco on 30/09/22.
//

import Foundation
import UIKit

class UpcomingViewController : UIViewController {
    
    @IBOutlet weak var tblMenu: UITableView!
    private var lstOptions = [MovieUpdate]()
    private var movieApi: MovieAPI = MovieAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        loadCellNav()
    }
    
    private func loadCellNav() {
        tblMenu.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        self.title = "Películas"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func loadData() {
        movieApi.getUpComing(completion: { lst in
            DispatchQueue.main.async {
                self.lstOptions = lst
                self.tblMenu.reloadData()
            }
        })
    }
    
}

extension UpcomingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return lstOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell else {
            return UITableViewCell()
        }
        cell.configureCellWithUrl(movieInfo: lstOptions[indexPath.row])
        return cell
    }
    
}
