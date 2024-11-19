//
//  PhotoCell.swift
//  juegoTareaiOs
//
//  Created by Lorena Pérez Jota  on 13/11/24.
//
import Foundation
import UIKit

class PhotoCell: UICollectionViewCell {


    @IBOutlet weak var CellimageV: UIImageView!
    
    @IBOutlet weak var CellButton: UIButton!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            
            // Asegúrate de que el botón esté encima de la imagen
        CellButton.layer.zPosition = 1 // Esto asegura que el botón esté por encima de la imagen
        CellButton.isHidden = false // Puedes controlar si el botón está visible o no
        }
}
