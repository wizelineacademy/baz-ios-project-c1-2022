//  MovieTableViewCell.swift
//  BAZProjectC1
//  Created by 291732 on 19/09/22.

import UIKit

final class MovieTableViewCell: UITableViewCell {
    //MARK: - O U T L E T S
    @IBOutlet weak var vwContainer: UIView!{
        didSet{ self.vwContainer.layer.borderColor = .init(red: 117/255, green: 31/255, blue: 34/255, alpha: 1) }
    }
    @IBOutlet weak var imgPoster: UIImageView!{
        didSet{ self.imgPoster.layer.cornerRadius = 15 }
    }
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblVote: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblFormat: UILabel!
    
    
    //MARK: -  V A R I A B L E S
    static var nib: UINib { return UINib(nibName: identifier, bundle: .main ) }
    private var downloadTask: URLSessionDownloadTask?
    
    
    //MARK: - F U N C T I O N S
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    ///Si un objeto UITableViewCell tiene un identificador de reutilización, la vista de tabla invoca este método justo antes de devolver el objeto del método  dequeueReusableCell(withIdentifier:).
    ///Para evitar posibles problemas de rendimiento, solo debe restablecer los atributos de la celda que no están relacionados con el contenido, por ejemplo, alfa, edición y estado de selección.
    ///El delegado de la vista de tabla en tableView(_:cellForRowAt:) siempre debe restablecer todo el contenido al reutilizar una celda.
    override func prepareForReuse(){
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
    }
    
    /// Funcion que configuta a la celda con un objeto Movie
    ///  - Parameter obj: Es el modelo que tiene los datos para pontar en la celda
    public func setInfoTrading(with movie: Movie) {
        if let urlPoster = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            downloadTask = imgPoster.loadImage(url: url)
        }
        let mediaT: String = (movie.mediaType == "movie") ? "Ahora en Cines" : "En Streaming"
        let dVote: Double = movie.voteAverage ?? 0.0
        self.lblTitle.text = movie.title
        self.lblOverview.text = movie.overview
        self.lblVote.text = String(format: "%.1f", dVote )
        self.lblDate.text = "Estreno: \(movie.releaseDate ?? "")"
        self.lblFormat.text = "\(mediaT) "
    }
}
