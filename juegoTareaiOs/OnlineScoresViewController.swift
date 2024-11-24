//
//  OnlineScoresViewController.swift
//  juegoTareaiOs
//
//  Created by Lorena Pérez Jota  on 24/11/24.
//
import Foundation
import UIKit

class OnlineScoresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var OnlineScoresTableView: UITableView!
    
    // Array para los Scores
    var scores: [(name: String, score: Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OnlineScoresTableView.dataSource = self
        OnlineScoresTableView.delegate = self
        
        // Cargar los puntajes al cargar la vista
        fetchScoresFromAPI()
    }
    
    // Obtener puntajes desde la API
    func fetchScoresFromAPI() {
        guard let url = URL(string: "https://qhavrvkhlbmsljgmbknr.supabase.co/rest/v1/scores?select=*") else {
            print("URL inválida")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFoYXZydmtobGJtc2xqZ21ia25yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA3MjY5MTgsImV4cCI6MjAxNjMwMjkxOH0.Ta-_lXGGwSiUGh0VC8tAFcFQqsqAvB8vvXJjubeQkx8", forHTTPHeaderField: "Authorization")
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFoYXZydmtobGJtc2xqZ21ia25yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA3MjY5MTgsImV4cCI6MjAxNjMwMjkxOH0.Ta-_lXGGwSiUGh0VC8tAFcFQqsqAvB8vvXJjubeQkx8", forHTTPHeaderField: "apikey") // Agregar apikey
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error al obtener los puntajes: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No se recibieron datos")
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    print("Respuesta JSON: \(jsonResponse)") // Verificar el contenido del JSON
                    
                    self?.scores = jsonResponse.compactMap { dict in
                        if let name = dict["name"] as? String, let score = dict["score"] as? Int {
                            return (name: name, score: score)
                        }
                        return nil
                    }
                    
                    DispatchQueue.main.async {
                        self?.OnlineScoresTableView.reloadData()
                    }
                }
            } catch {
                print("Error al parsear JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }

    
    // Número de filas en la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    // Configurar cada celda con datos de puntaje
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
        let score = scores[indexPath.row]
        cell.textLabel?.text = "\(score.name): \(score.score)" // Asegúrate de asignar contenido
        return cell
    }
}

