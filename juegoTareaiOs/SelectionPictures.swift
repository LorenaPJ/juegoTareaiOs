//
//  selectionPictures.swift
//  juegoTareaiOs
//
//  Created by Lorena Pérez Jota  on 24/10/24.
//

import UIKit

class SelectionPictures: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var ColorsCollectionV: UICollectionView!
    
    //Array de botones que presiona el jugador
    var PressedButtons: [Int] = []
    
    // Array de imágenes para el slideshow
    
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
        
        // Verifica si el collectionView está cargando correctamente
        //print("View did load")
        
    }
    /*
     Este método define cuántas celdas habrá en nuestro CollectionView
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Habra tantas celdas como items haya en el Array.
        return photos.count
    }
    
    /*
     Este método configura cada celda
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Usamos la celda reutilizable del storyboard y le aplicamos la clase PhotoCell que creamos en el otro script
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        cell.CellimageV.image = photos[indexPath.item] //Ponemos la imagen correspondiente en cada celda
        
        // Acción al botón
        cell.CellButton.tag = indexPath.item // Usamos el tag para identificar la celda
        cell.CellButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    // Acción del botón
    @objc func buttonTapped(_ sender: UIButton) {
        _ = sender.tag
         print("Botón presionado en la celda con índice \(sender.tag)") // Verifica si esta línea se está llamando
        
        //Lógica del boton
        
        
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
