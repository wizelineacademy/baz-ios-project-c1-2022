//
//  MoviesViewController.swift
//  BAZProjectC1
//
//  Created by Fernando Garcia Hernandez on 22/09/22.
//

import UIKit
import Foundation

class MoviesViewController: UIViewController {

    
    var postersMovieArray = MovieModel()
    var tappedCell: PosterCollectionCell!
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        navigationItem.title = "Home"
        self.TableView.register(UINib.init(nibName: "TableViewCell", bundle: Bundle(for: TableViewCell.self)), forCellReuseIdentifier: "cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        ejemplo()
    }
    
    func ejemplo(){
        
//        for api in EndPoint.allCases {
//            switch api {
//            case .trendingMovie:
//                print ("Es trending")
//            case .nowPlaying:
//                print ("Es now")
//            case .popular:
//                print ("Es popular")
//            case .topRated:
//                print ("Es rated")
//            case .upComming:
//                print ("Es up")
//            }
//        }
        
        
        self.view.showAnimation()
        let groupEndPoint = DispatchGroup()
        EndPoint.allCases.forEach { endpoint in
            groupEndPoint.enter()
            
            moviesRequest(requestUrl: endpoint.requestFrom) { data, error in
                print("API \(endpoint.requestFrom) TERMINADO!!")
             
                
                do{
                    guard let data = data else {
                        return
                    }
                    
                    
                    
                    let result = try JSONDecoder().decode(Results.self, from: data)
//                    completion(result.results)
                    
                    print(result)
                } catch {
                    debugPrint("The following error occurred: \(error.localizedDescription)")
                }
                
                
                
                
                groupEndPoint.leave()
                
            }
        }
        
        groupEndPoint.notify(queue:.main) {
            print("Endpoints completed")
            self.view.hideAnimation()
        }
        /*
        let baseUrl = "https://jsonplaceholder.typicode.com/"
        let endpoints = ["posts", "comments", "albums", "photos", "todos", "users"]

         
         let data = try! JSONDecoder().decode(ApiResponse.self, from: rawApiResponse.data(using: .utf8)!)
         
         
         
         
        self.view.showAnimation()
        let group = DispatchGroup()
        endpoints.forEach { endpoint in
            group.enter()
            performNetworkRequest(url: baseUrl + endpoint) { data, error in
                print("TAREA \(endpoint) TERMINADA..")
//                print("Error:- \(error)")
                group.leave()
            }
        }

        // notify the main thread when all task are completed
        group.notify(queue: .main) {
            print("SE COMPLETARON TODOS LAS PETICIONES")
            self.view.hideAnimation()
        }
        
        */
        
        
    }
    
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postersMovieArray.movieObject[section].posters.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        let rowArray = postersMovieArray.movieObject[indexPath.section].posters[indexPath.row]
        cell.updateCellWith(row: rowArray)
        
        //MARK: - Cell delegation
        cell.cellDelegate = self
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return postersMovieArray.movieObject.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.darkGray
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 0, width: 200, height: 44))
        headerView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.text = postersMovieArray.movieObject[section].sectionFilter
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

extension MoviesViewController: CollectionViewCellDelegate {

    
    func collectionView(collectionviewcell: CollectionViewCell?, index: Int, didTappedInTableViewCell: TableViewCell) {
        if let posterRow = didTappedInTableViewCell.rowWithPosters {
            
            self.tappedCell = posterRow[index]
            
            let vc = DetailMovieViewController(nibName: "DetailMovieViewController", bundle: nil)
            vc.detailMovie = self.tappedCell
            
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)

        }
    }
}
