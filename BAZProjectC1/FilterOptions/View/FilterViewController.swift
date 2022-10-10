//
//  FilterViewController.swift
//  BAZProjectC1
//
//  Created by 1054812 on 20/09/22.
//

import UIKit

// MARK: FilterViewController Protocol
protocol FilterViewControllerDelegate: AnyObject {
    func didSelect(filter: FiltersMovies)
}

final class FilterViewController: UIViewController {
    @IBOutlet weak var filterTableView: UITableView!
    
    private var filterSelected: FiltersMovies = .trending
    private var filters = FiltersMovies.allCases
    weak var delegate: FilterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Filters"
        self.view.backgroundColor = .systemTeal
        self.configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    private func configureCollectionView(){
        self.filterTableView.register(UITableViewCell.self, forCellReuseIdentifier: "filterCell")
        self.filterTableView.backgroundColor = .clear
        self.filterTableView.separatorColor = .clear
    }
}

// MARK:  - Extension CollectionViewDataSource.
extension FilterViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        var content = cell.defaultContentConfiguration()
        
        content.text = self.filters[indexPath.row].title
        content.textProperties.color = .white
        content.textProperties.font = UIFont(name: "Futura-Medium", size: 18.0) ?? .boldSystemFont(ofSize: 17.0)
        content.imageProperties.tintColor = .white
        content.image = UIImage(named: self.filters[indexPath.row].image)
        cell.contentConfiguration = content
        
        return cell
    }
}
// MARK:  - Extension CollectionViewDelegate.
extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(filter: self.filters[indexPath.row])
    }
}
