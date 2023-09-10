//
//  ViewController.swift
//  SmileChuckNorris
//
//  Created by Edgar Sargsyan on 28.08.23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    var jokeModel: JokeModel?

    var isRussian: Bool = false

    @IBAction func jokeButton(_ sender: Any) {
        makeRequest()
    }
    
    private func makeRequest() {
            var request = URLRequest(url: URL(string: "https://api.chucknorris.io/jokes/random")!)
            request.allHTTPHeaderFields = ["authToken": "nil"]
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data , response, error in
                if let data = data, let jokeModel = try? JSONDecoder().decode(JokeModel.self, from: data) {
                    DispatchQueue.main.async {
                        self.jokeModel = jokeModel
                    //    self.textLabel.text = jokeModel.value
                        self.updateJokeLabel()
                    }
                }
            }
            task.resume()
        }
    private func updateJokeLabel() {
           let jokeText = jokeModel?.value ?? NSLocalizedString("noJokeText", comment: "Placeholder text when no joke is loaded")
           textLabel.text = jokeText
       }
   }
