//
//  SimpleSearchTableViewCell.swift
//  BAZProjectC1
//
//  Created by 291732 on 04/10/22.
//

import UIKit

final class SimpleSearchTableViewCell: UITableViewCell {
    //MARK: - O U T L E T S
    @IBOutlet weak var lblTitle: UILabel!
    
    //MARK: -  V A R I A B L E S
    static var nib: UINib { return UINib(nibName: identifier, bundle: .main ) }

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
//        downloadTask?.cancel()
//        downloadTask = nil
    }
    
}
