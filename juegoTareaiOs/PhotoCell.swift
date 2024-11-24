//
//  PhotoCell.swift
//  juegoTareaiOs
//
//  Created by Lorena Pérez Jota  on 13/11/24.
//
import Foundation
import UIKit

class PhotoCell: UICollectionViewCell {

    //Imagen que tenemos en la celda.
    @IBOutlet weak var CellimageV: UIImageView!
    //Boton que tenemos en la celda.
    @IBOutlet weak var CellButton: UIButton!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            
        
        CellButton.layer.zPosition = 1 // Esto asegura que el botón esté por encima de la imagen
        CellButton.isHidden = false // Nos aseguramos que sea visible o no el boton
        }
}
