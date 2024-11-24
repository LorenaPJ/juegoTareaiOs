//
//  HighScoresViewcontroller.swift
//  juegoTareaiOs
//
//  Created by Lorena Pérez Jota  on 20/11/24.
//
import Foundation
import UIKit

class HighScoresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    // Array para almacenar los puntajes
    var scores: [(name: String, score: Int)] = []
    
    @IBOutlet weak var LocalScoreTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configurar el TableView
        LocalScoreTableView.dataSource = self
        LocalScoreTableView.delegate = self
        
        // Cargar las puntuaciones y ordenarlas
        loadScores()
    }
    
    // Número de filas en la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    // Configuración de cada celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Crear una celda reutilizable
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
        
        // Configurar la celda con los datos
        let scoreData = scores[indexPath.row]
        cell.textLabel?.text = "\(scoreData.name): \(scoreData.score) puntos"
        
        return cell
    }
    
    /*
     Función para cargar las puntuaciones desde UserDefaults
     */
    func loadScores() {
        if let storedScores = UserDefaults.standard.array(forKey: "scores") as? [[String: Any]] {
            // Convertir los datos a nuestro formato
            scores = storedScores.compactMap { dict in
                if let name = dict["name"] as? String, let score = dict["score"] as? Int {
                    return (name: name, score: score)
                }
                return nil
            }
            
            // Ordenar las puntuaciones de mayor a menor
            scores.sort { $0.score > $1.score }
            
            // Recargar el TableView para mostrar las puntuaciones ordenadas
            LocalScoreTableView.reloadData()
        }
    }
}
