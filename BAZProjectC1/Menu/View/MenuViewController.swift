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
    @IBOutlet weak var svContainer: UIScrollView!
     var pgDetail: UIPageControl!
    
    var lstOptions = [MenuRow(title: "Mas popular", detail: "Aquí encontrarás las peliculas más populares", image: "mostPopular"), MenuRow(title: "Listado Peliculas", detail: "Aquí encontrarás el listado de peliculas más reciente", image: "list"), MenuRow(title: "Proximamente", detail: "Aquí encontrarás el listado de peliculas más reciente", image: "list")]
    var lstMovies: [MovieUpdate] = []
    let movieApi = MovieAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getMostPopularMovies()
        
    }
    
    private func configureViewController() {
        tblMenu.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        self.title = "Películas"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func getMostPopularMovies() {
        movieApi.getMostPopular(completion: { lstInfo in
            self.lstMovies = lstInfo
            DispatchQueue.main.async { [weak self] in
                self?.setupScrollView()
            }
        })
    }
    
    private func setupScrollView() {
        
        svContainer.contentSize.width = self.svContainer.frame.width * CGFloat(lstMovies.count)
        svContainer.isPagingEnabled = true
        svContainer.delegate = self
        svContainer.bounces = false
        
        for (i, obj) in lstMovies.enumerated() {
            
            let view = ParallaxView()
            view.frame = CGRect(x: self.svContainer.frame.width * CGFloat(i), y: 0, width: self.svContainer.frame.width, height: 250)
            view.imgDetail.loadFrom(strUrl: obj.imageDetail)
            view.tag = i
            view.delegateParalax = self
            svContainer.addSubview(view)
        }
        pgDetail = UIPageControl(frame: CGRect(x: 0, y: svContainer.frame.height + 30, width: self.view.frame.width, height: 30))
        pgDetail.numberOfPages = lstMovies.count
        pgDetail.currentPage = 0
        pgDetail.addTarget(self, action: #selector(acChangeAction(_:)), for: .touchUpInside)
        svContainer.superview?.addSubview(pgDetail)
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
        case 2:
            let vc = sb.instantiateViewController(withIdentifier: "UpcomingViewController") as? UpcomingViewController
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        default:
            break
        }
    }
}

extension MenuViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pgDetail.currentPage = Int(pageIndex)
        
    }
    
    @IBAction func acChangeAction(_ sender: UIPageControl) {
        let v1 = pgDetail.numberOfPages
        if pgDetail.currentPage == (v1 - 2){
            pgDetail.currentPage = Int(self.pgDetail.currentPage ) + 1
            svContainer.setContentOffset(CGPoint(x: (Int(self.view.frame.size.width) * Int(self.pgDetail.currentPage)), y: 0), animated: true)
            
        }else{
            pgDetail.currentPage = Int(self.pgDetail.currentPage ) + 1
            svContainer.setContentOffset(CGPoint(x: (Int(self.view.frame.size.width) * Int(self.pgDetail.currentPage)), y: 0), animated: true)
        }
    }
}

extension MenuViewController : ParalaxProtocol {
    
    func didSelectItem(iIndex: Int) {
       changeView(iIndex: iIndex)
    }
    
    func changeView(iIndex: Int) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.objMov = lstMovies[iIndex]
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
}

