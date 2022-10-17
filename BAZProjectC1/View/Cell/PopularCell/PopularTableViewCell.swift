//  PopularTableViewCell.swift
//  BAZProjectC1
//  Created by 291732 on 21/09/22.

import UIKit

final class PopularTableViewCell: UITableViewCell {
    //MARK: - O U T L E T S
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblVote: UILabel!

    
    //MARK: -  V A R I A B L E S
    static var nib: UINib { return UINib(nibName: identifier, bundle: .main ) }
    private var downloadTask: URLSessionDownloadTask?
    private let wizelineClear: UIColor = .init(red: 211/255, green: 211/255, blue: 212/255, alpha: 1)
    private let wizelineClearBlue: UIColor = .init(red: 77/255, green: 93/255, blue: 109/255, alpha: 1)

    
    //MARK: - F U N C T I O N S
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default
                          .addObserver(self,
                           selector:#selector(updateColor(_:)),
                           name: NSNotification.Name("setNewColor"),
                           object: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setGradientOnImage(){
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: imgPoster.frame.width, height: imgPoster.frame.height)
        let startColor = UIColor.clear.cgColor
        let endColor = UIColor.black.cgColor
        gradient.colors = [startColor, endColor]
        imgPoster.layer.insertSublayer(gradient, at: 0)
    }
    
    ///Si un objeto UITableViewCell tiene un identificador de reutilización, la vista de tabla invoca este método justo antes de devolver el objeto del método  dequeueReusableCell(withIdentifier:).
    ///Para evitar posibles problemas de rendimiento, solo debe restablecer los atributos de la celda que no están relacionados con el contenido, por ejemplo, alfa, edición y estado de selección.
    ///El delegado de la vista de tabla en tableView(_:cellForRowAt:) siempre debe restablecer todo el contenido al reutilizar una celda.
    override func prepareForReuse(){
        super.prepareForReuse()
        self.setGradientOnImage()
        downloadTask?.cancel()
        downloadTask = nil
    }
    
    /// Funcion que configuta a la celda con un objeto Movie
    ///  - Parameter obj: Es el modelo que tiene los datos para pontar en la celda
    func setPopularView(with obj:Movie){
        if let urlPoster = obj.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            downloadTask = imgPoster.loadImage(url: url)
        }
        let dVote: Double = obj.voteAverage ?? 0.0
        self.lblTitle.text = obj.title
        self.lblOverview.text = obj.overview
        self.lblVote.text = String(format: "%.1f", dVote )
    }
    
    @objc func updateColor(_ notification: Notification){
        self.lblTitle.textColor = wizelineClearBlue
        self.lblOverview.textColor = wizelineClearBlue
        self.lblVote.textColor = wizelineClearBlue
    }
    
}
