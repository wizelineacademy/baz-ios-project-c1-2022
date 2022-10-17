//
//  SearchViewController.swift
//  BAZProjectC1
//
//  Created by efloresco on 02/10/22.
//

import UIKit

protocol SearchMovieImp : AnyObject {
    func selectOptions(with movie: MovieUpdate)
}

class SearchViewController: UIViewController {

    @IBOutlet weak var tblMenu: UITableView!
    @IBOutlet weak var vwPlace: UIView!
    @IBOutlet weak var svSearch: UISearchBar!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    weak var delegateSearch: SearchMovieImp?
    private var vmSearch = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadConfigNav()
        self.loadConfigTable()
        self.loadInfo()
    }
    
    private func loadInfo() {
        vmSearch.bindData = {
            DispatchQueue.main.async {
                self.loadConfiguration()
            }
        }
    }
    
    private func loadConfigNav() {
        self.title = "Buscar"
        svSearch.delegate = self
        svSearch.showsScopeBar = true
    }
    
    private func loadConfigTable() {
        tblMenu.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        tblMenu.delegate = self
        tblMenu.dataSource = self
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vmSearch.getNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell else {
            return UITableViewCell()
        }
        cell.configureCellWithUrl(movieInfo: vmSearch.movie(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if self.delegateSearch != nil {
            self.delegateSearch?.selectOptions(with: self.vmSearch.movie(at: indexPath.row))
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController : UISearchBarDelegate  {
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar) {
        
        vmSearch.callServices(strDatos: searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        cleanControl()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cleanControl()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        cleanControl()
    }
    
    private func loadConfiguration() {
        if self.vmSearch.getNumberOfItems() > 0 {
            self.loadTable()
        } else {
            self.loadConfig()
        }
    }
    
    private func loadTable() {
        tblMenu.isHidden = false
        vwPlace.isHidden = true
        tblMenu.reloadData()
    }
    
    private func loadConfig() {
        tblMenu.isHidden = true
        vwPlace.isHidden = false
    }
    
    private func cleanControl() {
        vwPlace.isHidden = true
        tblMenu.isHidden = true
    }
}
