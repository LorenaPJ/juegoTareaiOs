//
//  selectionPictures.swift
//  juegoTareaiOs
//
//  Created by Lorena Pérez Jota  on 24/10/24.
//
import UIKit

class SelectionPictures: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //Nuestro collectionview
    @IBOutlet weak var ColorsCollectionV: UICollectionView!
    
    //Boton para siguiente pantalla
    @IBOutlet weak var localScoresButton: UIButton!
    
    
    
    // Array de imágenes para el slideshow
    var photos = ["amarillo", "azul", "rojo",
                  "azulclaro", "degradado", "verde",
                  "naranja", "morado", "rosado",
                  "verdeclaro", "ultima"
    ]
    
    // Array para guardar los botones presionados por el jugador
    var PressedButtons: [String] = []
    
    // Puntaje
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Confirmación de que el array viajó con exito.
        print("Imágenes recibidas desde gamescreen: \(shownImages)")
        
        ColorsCollectionV.dataSource = self
        ColorsCollectionV.delegate = self
    }
    
    // Método para configurar el número de celdas en el CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    // Configurar cada celda con una imagen y un botón
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        // Asignar la imagen a la celda
        cell.CellimageV.image = UIImage(named: photos[indexPath.item])
        
        // Asignar el nombre de la imagen como el identificador del botón
        cell.CellButton.setTitle(photos[indexPath.item], for: .normal)
        // Usamos el nombre de la imagen como el título para poder diferenciarlo
        
        // Añadir la acción del botón para saber cuál fue presionado
        cell.CellButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    // Acción cuando se presiona un botón
    @objc func buttonTapped(_ sender: UIButton) {
        
        // Usamos el título del botón (el nombre de la imagen) y lo agregamos a PressedButtons
        if let buttonTitle = sender.title(for: .normal) {
            // Verificar que el botón no haya sido presionado antes
            if !PressedButtons.contains(buttonTitle) {
                // Agregar el título del botón a PressedButtons
                PressedButtons.append(buttonTitle)
                
                // Comprobar si la respuesta es correcta
                checkAnswer(buttonTitle)
                
                print("Botón presionado: \(buttonTitle)")
            } else {
                print("Este botón ya ha sido presionado")
            }
        }
    }
    
    /*
     Método para comparar las selecciones del jugador con las imágenes mostradas
     */
    func checkAnswer(_ selectedButton: String) {
        
        // Compara la imagen presionada con la imagen correspondiente en shownImages
        if PressedButtons.count <= shownImages.count {
            let index = PressedButtons.count - 1
            if selectedButton == shownImages[index] {
                score += 1
                print("¡Correcto! Puntaje: \(score)")
            } else {
                print("Incorrecto. Puntaje: \(score)")
            }
        }
        
        // Verifica si el jugador ha presionado todos los botones
        if PressedButtons.count == shownImages.count {
            // Si ha terminado, muestra el puntaje final
            showFinalScore()
        }
    }
    /*
     Nos muestra el puntaje final del jugador y le pide el nombre para guardarlo.
     */
    func showFinalScore() {
        // Crear el UIAlertController para pedir el nombre
        let alert = UIAlertController(title: "Juego Terminado", message: "Tu puntaje final es \(score) de \(shownImages.count)", preferredStyle: .alert)
        
        // Agregar el TextField
        alert.addTextField { (textField) in
            textField.placeholder = "Ingresa tu nombre"
        }
        
        // Acción de aceptar
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { [weak alert] _ in
            if let playerName = alert?.textFields?.first?.text, !playerName.isEmpty {
                // Guardar la puntuación localmente
                self.saveScore(name: playerName, score: self.score)
                self.navigateToScoreView()
                
                // Subir la puntuación a la API
                self.uploadScoreToAPI(name: playerName, score: self.score)
            } else {
                print("No se ingresó un nombre válido")
            }
        }))
        
        // Mostrar la alerta
        present(alert, animated: true, completion: nil)
    }
    // Subir la puntuación a una API
    func uploadScoreToAPI(name: String, score: Int) {
        // URL de la API
        guard let url = URL(string: "https://qhavrvkhlbmsljgmbknr.supabase.co/rest/v1/scores") else {
            print("URL inválida")
            return
        }
        
        // Crear el objeto con los datos del puntaje
        let parameters = ["name": name, "score": score] as [String : Any]
        
        // Configurar la solicitud
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFoYXZydmtobGJtc2xqZ21ia25yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA3MjY5MTgsImV4cCI6MjAxNjMwMjkxOH0.Ta-_lXGGwSiUGh0VC8tAFcFQqsqAvB8vvXJjubeQkx8", forHTTPHeaderField: "Authorization")
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFoYXZydmtobGJtc2xqZ21ia25yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA3MjY5MTgsImV4cCI6MjAxNjMwMjkxOH0.Ta-_lXGGwSiUGh0VC8tAFcFQqsqAvB8vvXJjubeQkx8", forHTTPHeaderField: "apikey")

        do {
            // Convertir los parámetros a JSON
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
            
            // Realizar la solicitud HTTP
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error al subir la puntuación: \(error.localizedDescription)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("Código de estado: \(httpResponse.statusCode)")
                    if httpResponse.statusCode == 201 {
                        print("Puntuación subida correctamente")
                    } else {
                        print("Error al subir la puntuación, código de estado: \(httpResponse.statusCode)")
                    }
                }
                
                if let data = data {
                    // Manejar la respuesta de la API
                    if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) {
                        print("Respuesta de la API: \(jsonResponse)")
                    }
                }
            }
            
            // Iniciar la tarea
            task.resume()
        } catch {
            print("Error al convertir parámetros a JSON: \(error.localizedDescription)")
        }
    }


    
    /*
     Metodo para guardar la puntuación en UserDefaults
     */
    func saveScore(name: String, score: Int) {
        var scores = UserDefaults.standard.array(forKey: "scores") as? [[String: Any]] ?? []
        
        let scoreData: [String: Any] = ["name": name, "score": score]
        scores.append(scoreData)
        
        UserDefaults.standard.setValue(scores, forKey: "scores")
        print("Puntuación guardada localmente")
        print(scores)
    }
    
    /*
     Enviar información al TableView
     */
    func navigateToScoreView() {
        // Instanciar el ScoreViewController desde el storyboard
        if let scoreVC = storyboard?.instantiateViewController(withIdentifier: "HighScoresViewController") as? HighScoresViewController {
            // Navegar a la nueva pantalla
            navigationController?.pushViewController(scoreVC, animated: true)
        }
    }
}
