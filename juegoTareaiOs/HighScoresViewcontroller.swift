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
   
   override func viewDidLoad() {
       super.viewDidLoad()
       // Configurar el TableView
       LocalScoreTableView.dataSource = self
       LocalScoreTableView.delegate = self
       
       loadScores()
       
   }
   
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return scores.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           // Crear una celda reutilizable
           let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
           
           // Configurar la celda con los datos
           let scoreData = scores[indexPath.row]
           cell.textLabel?.text = "\(scoreData.name): \(scoreData.score) puntos"
           
           return cell
       }
    
    func loadScores() {
        if let storedScores = UserDefaults.standard.array(forKey: "scores") as? [[String: Any]] {
            // Convertir los datos a tu formato
            scores = storedScores.compactMap { dict in
                if let name = dict["name"] as? String, let score = dict["score"] as? Int {
                    return (name: name, score: score)
                }
                return nil
            }
            // Recargar el TableView
            LocalScoreTableView.reloadData()
        }
    }
   
   @IBOutlet weak var LocalScoreTableView: UITableView!
}
 
 /*
 // Recuperar las puntuaciones guardadas
 scores = UserDefaults.standard.array(forKey: "scores") as? [[String: Any]] ?? []
 self.tableView.reloadData()
 
 // Configurar el número de filas en la tabla
 override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return scores.count
 }
 
 */
