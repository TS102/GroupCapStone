//
//  ResultsViewController.swift
//  Q'Hoot
//
//  Created by Tyler Sun on 4/24/23.
//

import UIKit

class ResultsViewController: UIViewController {

    var category = ""
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

        guessesLabel.text = "\(team1Guesses)"
        print(team1Guesses, team2Guesses, team3Guesses)
        showResultsAlert()
        
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
                    "prompt": "you are a word scanner that will scan an array and give me the number of corrects words from that array based on a category. here is the array of words\(team1Guesses), and this is the category \(category) give me only the number.",
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
    
    func showResultsAlert() {
        let image = UIImage(named: "QHOOT LOGO")
        let alert = UIAlertController(title: "Good Work", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Get results", style: .default) { (action) in
            self.apiCall()
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
    
 
    @IBAction func buttonTapped(_ sender: Any) {
//        apiCall()
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
