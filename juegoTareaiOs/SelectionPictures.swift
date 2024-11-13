//
//  selectionPictures.swift
//  juegoTareaiOs
//
//  Created by Lorena Pérez Jota  on 24/10/24.
//
import UIKit

class SelectionPictures: UIViewController{
    
   
    @IBOutlet weak var ColorsCollectionV: UICollectionView!
    
    
    // Array de imágenes para la galería
    var photos: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Las cargamos
        photos = [
            UIImage(named: "amarillo")!,
            UIImage(named: "azul")!,
            UIImage(named: "rojo")!,
            UIImage(named: "azulclaro")!,
            UIImage(named: "degradado")!,
            UIImage(named: "verde")!,
            UIImage(named: "naranja")!,
            UIImage(named: "morado")!,
            UIImage(named: "rosado")!,
            UIImage(named: "verdeclaro")!
        ]
    }
    
    // Este método define cuántas celdas habrá en el UICollectionView
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return photos.count
        }
        
        // Este método configura cada celda
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            // Obtén la celda reutilizable
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
            
            // Configura la celda con la imagen correspondiente
            let image = photos[indexPath.item]
            cell.CellimageV.image = image
            
            return cell
        }
         
    
}
