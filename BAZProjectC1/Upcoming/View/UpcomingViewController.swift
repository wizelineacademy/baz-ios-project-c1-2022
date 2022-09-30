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
    var lstOptions = [MovieUpdate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        let obj = MovieAPI()
        obj.getUpComing(completion: { lst in
            print("Info \(lst)")
            self.lstOptions = lst
            
            DispatchQueue.main.async {
            self.tblMenu.reloadData()
            }
        })
    }
    
    func configureViewController() {
        tblMenu.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        self.title = "Películas"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // self.navigateToDetailViewController(with: indexPath.row)
       
    }
    
    func navigateToDetailViewController(with index: Int) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        switch index {
        case 0:
            let vc = sb.instantiateViewController(withIdentifier: "TrendingViewController") as? TrendingViewController
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        case 1:
            let vc = sb.instantiateViewController(withIdentifier: "BillboardViewController") as? BillboardViewController
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        case 2:
            let vc = sb.instantiateViewController(withIdentifier: "UpcomingViewController") as? UpcomingViewController
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        default:
            break
        }
    }
    
}
