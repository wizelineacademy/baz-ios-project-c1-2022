//
//  MenuViewController.swift
//  BAZProjectC1
//
//  Created by efloresco on 20/09/22.
//

import Foundation
import UIKit

class MenuViewController : UIViewController {
    
    @IBOutlet weak var tblMenu: UITableView!
    var lstOptions = [MenuRow(title: "Mas popular", detail: "Aquí encontrarás las peliculas más populares", image: "mostPopular"), MenuRow(title: "Listado Peliculas", detail: "Aquí encontrarás el listado de peliculas más reciente", image: "list")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    func configureViewController() {
        tblMenu.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        self.title = "Películas"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
}

extension MenuViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return lstOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell else {
            return UITableViewCell()
        }
        cell.configureCellMenu(with: lstOptions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToDetailViewController(with: indexPath.row)
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
        default:
            break
        }
    }
    
}
