//
//  HighScoresViewcontroller.swift
//  juegoTareaiOs
//
//  Created by Lorena Pérez Jota  on 20/11/24.
//
import Foundation
import UIKit
class HighScoresViewController: UITableViewController {
    
    var scores: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Recuperar las puntuaciones guardadas
        scores = UserDefaults.standard.array(forKey: "scores") as? [[String: Any]] ?? []
        self.tableView.reloadData()
    }
    
    // Configurar el número de filas en la tabla
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
}
