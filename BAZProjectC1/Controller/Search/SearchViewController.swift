//  SearchViewController.swift
//  BAZProjectC1
//  Created by 291732 on 28/09/22.

import UIKit

final class SearchViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet private weak var tblSearch: UITableView!{
        didSet{
            self.tblSearch.delegate = self
            self.tblSearch.dataSource = self
            self.tblSearch.register(SeachTableViewCell.nib, forCellReuseIdentifier: SeachTableViewCell.identifier)
        }
    }
    
    private let wizelineBlue: UIColor = UIColor(red: 12/255, green: 24/255, blue: 35/255, alpha: 1)
    private let arrTitles: [String] = ["Trending", "Now Playing", "Popular", "Top Rated", "Upcoming"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

//MARK: - EXT-> UI · T A B L E · V I E W · D E L E G A T E
extension SearchViewController: UITableViewDelegate & UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { return arrTitles.count }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat { 70 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SeachTableViewCell.identifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrTitles[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        returnedView.backgroundColor = wizelineBlue
        let label = UILabel(frame: CGRect(x: 8, y: 25, width: view.frame.size.width, height: 45))
        label.textColor = .white
        label.font.withSize(35)
        label.text = self.arrTitles[section]
        returnedView.addSubview(label)
        return returnedView
    }
}
