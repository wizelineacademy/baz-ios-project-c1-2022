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
    
    weak var delegateSearch: SearchMovieImp?

    @IBOutlet weak var tblMenu: UITableView!
    @IBOutlet weak var vwPlace: UIView!
    @IBOutlet weak var svSearch: UISearchBar!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    var lstMovies: [MovieUpdate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadConfigNav()
        self.loadConfigTable()
        
    }
    
    func loadConfigNav() {
        self.title = "Buscar"
        svSearch.delegate = self
        svSearch.showsScopeBar = true
    }
    
    func loadConfigTable() {
        tblMenu.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        tblMenu.delegate = self
        tblMenu.dataSource = self
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lstMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell else {
            return UITableViewCell()
        }
        cell.configureCellWithUrl(movieInfo: lstMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if self.delegateSearch != nil {
            self.delegateSearch?.selectOptions(with: self.lstMovies[indexPath.row])
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController : UISearchBarDelegate  {
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar) {
        let movieApi = MovieAPI()
        movieApi.getQuerySearch(strQuery: searchBar.text ?? "", completion: { lst in
            DispatchQueue.main.async {
                self.lstMovies = lst
                
                if lst.count > 0 {
                    self.loadTable()
                } else {
                    self.loadConfig()
                }
            }
        })
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
    
    func loadTable() {
        tblMenu.isHidden = false
        vwPlace.isHidden = true
        tblMenu.reloadData()
    }
    func loadConfig() {
        tblMenu.isHidden = true
        vwPlace.isHidden = false
    }
    func cleanControl() {
        vwPlace.isHidden = true
        tblMenu.isHidden = true
    }
}
