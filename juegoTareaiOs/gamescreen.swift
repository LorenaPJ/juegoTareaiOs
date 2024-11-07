//
//  gamescreen.swift
//  juegoTareaiOs
//
//  Created by Lorena Pérez Jota  on 19/10/24.
//
import UIKit

class gamescreen: UIViewController {
    
    // Imagen del UI que cambia
    @IBOutlet weak var changingImage: UIImageView!

    // Array de imágenes totales.
    let imagenes = ["amarillo", "azul", "degradado","azulclaro","morado","naranja", "verdeclaro", "rosado", "rojo", "verde"]
    //Array de imagenes que muestra la app.
    var shownImages : [String] = []
    //variable para ver en q imagen estamos.
    var currentIndex = 0
    //variable para nuestro temporizador
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Seleccionar 5 imagenes random.
        selectRandomImages()
        // Iniciar el temporizador
        startImageTimer()
    }
    
    /*
     Se seleccionan 5 imagenes random de nuestro array de imagenes.
     Las imagenes seleccionadas se almacenan en un array nuevo 'shownImages'.
     */
    func selectRandomImages() {
        
        //imagenes únicas seleccionadas
        var selectedIndices: Set<Int> = []
        //se asegura de que sean solo 5 imagenes seleccionadas
        while selectedIndices.count < 5 {
            let randomIndex = Int.random(in: 0..<imagenes.count)
            selectedIndices.insert(randomIndex)
        }
        
        shownImages = selectedIndices.map { imagenes[$0] }
    }
    /*
     Timer para que nuestras imagenes aparezcan en secuencia cada
     2 segundos.
     */
    func startImageTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
        }

    @objc func changeImage() {
           // Cambia la imagen en changingImage según donde se encuentre el 'currentIndex'
           changingImage.image = UIImage(named: shownImages[currentIndex])
           
           // Incrementa el índice
           currentIndex += 1
           
           // Verifica si ya llegamos al final del array de las imágenes que hay que mostrar
           if currentIndex >= shownImages.count {
               // Muestra la imagen "ultima"
               self.changingImage.image = UIImage(named: "ultima")
               
               // Detiene el temporizador
               timer?.invalidate()
               timer = nil // Nos aseguramos de que no se reinicie otra vez
           }
       }

       deinit {
           // Invalidar el temporizador cuando la vista se acabe.
           timer?.invalidate()
       }
   }
