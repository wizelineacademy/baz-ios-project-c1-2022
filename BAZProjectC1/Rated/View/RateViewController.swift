//
//  RateViewController.swift
//  BAZProjectC1
//
//  Created by efloresco on 30/09/22.
//

import Foundation
import UIKit

class RateViewController : UIViewController {
     
    @IBOutlet weak var tblMenu: UITableView!
    private var lstOptions = [MovieUpdate]()
    private var vmRate = RateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        loadCell()
        
    }
    
    private func loadCell() {
        tblMenu.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        self.title = "Películas"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func loadData() {
        vmRate.bindData = {
            DispatchQueue.main.async {
                self.tblMenu.reloadData()
            }
        }
    }
    
}

extension RateViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vmRate.getNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell else {
            return UITableViewCell()
        }
        cell.configureCellWithUrl(movieInfo: vmRate.movie(at: indexPath.row))
        return cell
    }
    
}
