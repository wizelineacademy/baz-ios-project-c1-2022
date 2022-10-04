//
//  Main.swift
//  BAZProjectC1
//
//  Created by Jacobo Diaz on 01/10/22.
//

import UIKit

class Main: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var allRightsReserved: UILabel!
    @IBOutlet weak var indicatorLoadingData: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)
        self.allRightsReserved.text = "Jacobo Díaz \(yearString) - Todos los derechos reservados :P"
        self.getAllData()
    }
    
    func getAllData(){
        
        let movieApi = MovieAPI()
        movieApi.getMoviesNowPlaying { moviesNowPlaying in
            self.appDelegate.listMoviesNowPlaying = moviesNowPlaying
            movieApi.getMoviesTrending { moviesTrending in
                self.appDelegate.listMoviesTrending = moviesTrending
                movieApi.getMoviesPopular { moviesPopular in
                    self.appDelegate.listMoviesPopular = moviesPopular
                    movieApi.getMoviesTopRated { moviesTopRated in
                        self.appDelegate.listMoviesTopRated = moviesTopRated
                        movieApi.getMoviesUpcoming { moviesUpcoming in
                            self.appDelegate.listMoviesUpcoming = moviesUpcoming
                            DispatchQueue.main.async {
                                self.indicatorLoadingData.stopAnimating()
                                self.navigateTo()
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    func navigateTo(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Movies", bundle:nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        let navigationController = UINavigationController(rootViewController: newViewController)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        UIView.transition(with: appdelegate.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
            appdelegate.window!.rootViewController = navigationController
        })
    }
    
}
