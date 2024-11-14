//
//  selectionPictures.swift
//  juegoTareaiOs
//
//  Created by Lorena Pérez Jota  on 24/10/24.
//
import UIKit

class SelectionPictures: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    @IBOutlet weak var ColorsCollectionV: UICollectionView!
    
    
    // Array de imágenes para la galería

    var photos = [
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
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        ColorsCollectionV.dataSource = self
        ColorsCollectionV.delegate = self
        
    }
    /*
     Este método define cuántas celdas habrá en nuestro CollectionView
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    /*
     Este método configura cada celda
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.CellimageV.image = photos[indexPath.item]
        print("\(indexPath.item)")
        return cell
    }
}








/*
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return photos.count
 }
 
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     // Obtén la celda reutilizable
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
     
     // Configura la celda con la imagen correspondiente
     let image = photos[indexPath.item]
     cell.CellimageV.image = image
     
     return cell
 }
 */
