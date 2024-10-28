//
//  gamescreen.swift
//  juegoTareaiOs
//
//  Created by Lorena Pérez Jota  on 19/10/24.
//
import UIKit

class gamescreen: UIViewController {
    
    // Tu UIImageView llamado changingImage
    @IBOutlet weak var changingImage: UIImageView!

    // Array de imágenes
    let imagenes = ["amarillo", "azul", "degradado", "rosado", "rojo", "verde","ultima"]
    var currentIndex = 0
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Iniciar el temporizador
        startImageTimer()
    }

    func startImageTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
    }

    @objc func changeImage() {
        // Cambiar la imagen en changingImage
        changingImage.image = UIImage(named: imagenes[currentIndex])
        
        // Incrementar el índice
        currentIndex += 1
        
        // Verificar si hemos alcanzado el final del array
        if currentIndex >= imagenes.count {
            // Invalidar el temporizador y reiniciar el índice
            timer?.invalidate()
            timer = nil
            currentIndex = 0
        }
    }

    deinit {
        // Invalidar el temporizador cuando la vista se deallocate
        timer?.invalidate()
    }
}
