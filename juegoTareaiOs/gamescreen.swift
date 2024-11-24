//
//  gamescreen.swift
//  juegoTareaiOs
//
//  Created by Lorena Pérez Jota  on 19/10/24.
//
import UIKit

// Array de imágenes que muestra la app, hecho global.
var shownImages: [String] = []

class gamescreen: UIViewController {
    
  
    
    @IBOutlet weak var changingImage: UIImageView!
    //Array de todas las imágenes que maneja la aplicación.
    var imagenes = ["amarillo", "azul", "degradado",
                    "azulclaro", "morado", "naranja",
                    "verdeclaro", "rosado", "rojo",
                    "verde"]
    var currentIndex = 0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Selecciona 6 imágenes aleatorias.
        selectRandomImages()
        
        // Iniciar el temporizador para el cambio de imágenes.
        startImageTimer()
    }
    /*
     Usamos un random para escoger 5 imagenes y meterlas en nuestro array de imagenes mostradas.
     */
    func selectRandomImages() {
        var availableIndices = Array(0..<imagenes.count)
        shownImages = [] // Limpiar el array
        
        for _ in 0..<6 {
            let randomIndex = Int.random(in: 0..<availableIndices.count)
            let selectedIndex = availableIndices.remove(at: randomIndex)
            shownImages.append(imagenes[selectedIndex])
        }
        
        print("Imágenes seleccionadas para el slideshow: \(shownImages)") //Comprobación de que se llenó el array.
    }
    /*
     Timer para que las imágenes se muestren cada 2 segundos.
     */
    func startImageTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
    }
    /*
     Función para cambiar las imágenes con el orden de nuestro array. Al finalizar se coloca una ultima imágen predeterminada.
     */
    @objc func changeImage() {
        if currentIndex < shownImages.count {
            changingImage.image = UIImage(named: shownImages[currentIndex])
            currentIndex += 1
        } else {
            changingImage.image = UIImage(named: "ultima")
            timer?.invalidate()
            timer = nil
        }
    }
}

