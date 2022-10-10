//  TopRatedTableViewCell.swift
//  BAZProjectC1
//  Created by 291732 on 21/09/22.

import UIKit

final class TopRatedTableViewCell: UITableViewCell {
    //MARK: - O U T L E T S
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UITextView!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblAverage: UILabel!
    @IBOutlet weak var sldRated: UISlider!

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
    
    /// Funcion que configura un slider dado un valor inicial
    /// - Parameter val: Valor de tipo Float para incializar el valor en el que estara asignado al iniciar el componente
    private func setSlider(withValue val: Float) {
        sldRated.setThumbImage(UIImage(systemName: "hand.thumbsup.fill")?.withTintColor(.white), for: .normal)
        sldRated.isContinuous = false
        sldRated.isEnabled = false
        sldRated.minimumTrackTintColor = .red
        sldRated.maximumTrackTintColor = .white
        sldRated.minimumValue = 0
        sldRated.maximumValue = 100
        sldRated.setValue(val, animated: true)
    }
    
    /// Funcion que configuta a la celda con un objeto Movie
    ///  - Parameter obj: Es el modelo que tiene los datos para pontar en la celda
    func setTopRated(with obj:Movie) {
        if let urlPoster = obj.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            downloadTask = imgPoster.loadImage(url: url)
        }
        let dVote: Double = obj.voteAverage ?? 0.0
        self.lblTitle.text = obj.title
        self.lblDesc.text = obj.overview
        self.lblTotal.text = "Votos hasta ahora: \(obj.voteCount ?? 0)"
        self.lblAverage.text =  "Promedio de Votos: \(String(format: "%.1f", dVote))"
        self.setSlider(withValue: Float(obj.popularity ?? 0.0))
    }

}
