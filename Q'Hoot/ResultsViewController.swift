//
//  ResultsViewController.swift
//  Q'Hoot
//
//  Created by Tyler Sun on 4/24/23.
//

import UIKit

protocol ResultsViewControllerDelegate {
    func sendData(team1: [String], team2: [String], team3: [String], numberOfTeams : Int, ishidden: Bool?)
}

class ResultsViewController: UIViewController {
    
    var delegate: ResultsViewControllerDelegate?
    
    var numberOfTeams: Int = 1
    var category = ""
    var timer: Timer?
    var prompt = ""
    // MARK: going to be using these for later
    var team1Guesses: [String] = []
    var team2Guesses: [String] = []
    var team3Guesses: [String] = []
    
    
    let defaults = UserDefaults.standard

    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var team1Label: UILabel!
    @IBOutlet weak var team2Label: UILabel!
    @IBOutlet weak var team3Label: UILabel!
    @IBOutlet weak var chatLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem .setHidesBackButton(true, animated: false)
        categoryLabel.text = category
        
        hideLabel()
        team1Label.text = "Team 1 Guesses: \(team1Guesses.joined(separator: ", "))"
        team2Label.text = "Team 2 Guesses: \(team2Guesses.joined(separator: ", "))"
        team3Label.text = "Team 3 Guesses: \(team3Guesses.joined(separator: ", "))"
        
        print(team1Guesses, team2Guesses, team3Guesses)
        showResultsAlert()
        
        // Do any additional setup after loading the view.
    }
    
    
    func apiCall() {
        let url = URL(string: "https://api.openai.com/v1/completions")!
        // MARK: delete api key before pushing
        let apiKey = ""
        let headers = ["Content-Type": "application/json",
                       "Authorization": "Bearer " + apiKey]
        switch numberOfTeams {
        case 1 : prompt = "you are game master for a trivia like game where the user is going to give you words that relate to a certain category. you'll give me a score based on how many words are related to the category provided and give them more points for how closely related the words are to that category. the category is \(category), and the words the user has given are \(team1Guesses) give me only the score."
        case 2: prompt = "you are game master for a trivia like game where teams are going to give you words that relate to a certain category. you'll give me a score based on how many words are related to the category provided and give them more points for how closely related the words are to that category. the category is \(category), and the words that team one has given are \(team1Guesses) and this is team twos words \(team2Guesses) respond with only the scores for each team and who won."
        case 3: prompt = "you are game master for a trivia like game where teams are going to give you words that relate to a certain category. you'll give me a score based on how many words are related to the category provided and give them more points for how closely related the words are to that category. the category is \(category), and the words that team one has given are \(team1Guesses), and this is team twos words \(team2Guesses), team threes words are \(team3Guesses), respond with only the scores for each team and who won."
        default: print("error")
        }

        let data = ["model": "text-davinci-003",
                    "prompt": "\(prompt)",
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
//                        guard let score = Int(text) else { return }
//                        self.teamScores.append(score)
                        
                        self.chatLabel.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
                        self.chatLabel.baselineAdjustment = .alignCenters
                        print(text)
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
    
    func showResultsAlert() {
        let image = UIImage(named: "whiteOwl")
        let alert = UIAlertController(title: "Good Work", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Get results", style: .default) { (action) in
            self.apiCall()
//            print(self.prompt)
        }
        
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        let titleString = NSAttributedString(string: "Good Work", attributes: titleAttributes)
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        let messageString = NSAttributedString(string: "Ready to see results", attributes: messageAttributes)
        alert.setValue(titleString, forKey: "attributedTitle")
        alert.setValue(messageString, forKey: "attributedMessage")
        
        let imageView = UIImageView(frame: CGRect(x: 72.5, y: 90, width: 250, height: 230))
        imageView.image = image
        

        let height: NSLayoutConstraint = NSLayoutConstraint(item: alert.view as Any, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0.5, constant: self.view.frame.height * 0.50)
        
        let width: NSLayoutConstraint = NSLayoutConstraint(item: alert.view as Any, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: self.view.frame.width * 1)
        
        alert.addAction(action)
        alert.view.addSubview(imageView)
        alert.view.addConstraint(height)
        alert.view.addConstraint(width)
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideLabel() {
        switch numberOfTeams {
        case 1:
            team2Label.isHidden = true
            team3Label.isHidden = true
        case 2:
            team3Label.isHidden = true
        default:
            print("show all three labels")
        }
        
    }
    
 
    @IBAction func buttonTapped(_ sender: Any) {
        performSegue(withIdentifier: "ResetGame", sender: nil)
        delegate?.sendData(team1: team1Guesses, team2: team2Guesses, team3: team3Guesses, numberOfTeams: numberOfTeams, ishidden: nil)
    }
}
