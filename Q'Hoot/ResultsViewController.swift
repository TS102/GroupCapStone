//
//  ResultsViewController.swift
//  Q'Hoot
//
//  Created by Tyler Sun on 4/24/23.
//

import UIKit

class ResultsViewController: UIViewController {

    var category = ""
    var userGuesses: [String] = []
    var timer: Timer?
    
    // MARK: going to be using these for later
    var team1Guesses: [String] = []
    var team2Guesses: [String] = []
    var team3Guesses: [String] = []
    
    // put all the teams scores in this array
    var teamScores: [Int] = []
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var guessesLabel: UILabel!
    @IBOutlet weak var chatLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryLabel.text = category
        guessesLabel.text = "\(userGuesses)"
        
        // Do any additional setup after loading the view.
    }
    


    // MARK: implement this later when we get the teams part working
//    you are a word scanner that will scan an array and give me the number of corrects words from that array based on a category. here is array one: ["red, "blue", "green", "car"], array two: ["red, "blue", "green", "car", "purple", "grey"], array three: ["red, "fish", "green", "car"].  and the category is colors give me the shortest answer possible which should be only numbers.
    
    func apiCall() {
        let url = URL(string: "https://api.openai.com/v1/completions")!
        let apiKey = ""
        let headers = ["Content-Type": "application/json",
                       "Authorization": "Bearer " + apiKey]
        let data = ["model": "text-davinci-003",
                    "prompt": "you are a word scanner that will scan an array and give me the number of corrects words from that array based on a category. here is the array of words\(userGuesses), and this is the category \(category) give me only the number.",
                    "max_tokens": 25,
                    "temperature": 0.2
        ] as [String : Any]
        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: [])
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print("Error: \(String(describing: error))")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let choices = json?["choices"] as? [[String: Any]], let text = choices.first?["text"] as? String {
                    DispatchQueue.main.async {
                        // attatch the label to the the chats response here
                        guard let score = Int(text) else { return }
                        self.teamScores.append(score)
                        self.chatLabel.text = String(score)
                        print(score)
                        }
                } else {
                    print("\(String(describing: json))")
                    //        } else {
                    //          print("\(json)") USE THIS IF THE APP DOESNT WORK
                }
            } catch {
                print("Error decoding response: \(error.localizedDescription)")
            }
        }.resume()
    }
    
 
    @IBAction func buttonTapped(_ sender: Any) {
        apiCall()
    
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
