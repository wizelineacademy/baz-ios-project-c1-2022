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
    var lstOptions = [["title": "Mas popular", "detail": "Aquí encontrarás las peliculas más populares" ,"image": "mostPopular"], ["title": "Listado Peliculas", "detail": "Aquí encontrarás el listado de peliculas más reciente" ,"image": "list"]]
    
    override func viewDidLoad() {
        self.title = "Películas"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        super.viewDidLoad()
    }
}

extension MenuViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return lstOptions.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell
        if cell == nil {
            tableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell
        }
        cell?.configureCell(dctInfo: lstOptions[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        switch indexPath.row {
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
