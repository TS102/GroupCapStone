//
//  ResultsViewController.swift
//  Q'Hoot
//
//  Created by Tyler Sun on 4/24/23.
//

import UIKit

class ResultsViewController: UIViewController {

    var category = "Food"
    var userGuesses = ["Pizza", "Cars", "Chicken", "laptop", "shoes", "columbus", "Pears", "pirates", "hotdog"]
    var chatMessage = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func apiCall() {
        let url = URL(string: "https://api.openai.com/v1/completions")!
        let apiKey = "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"
        let headers = ["Content-Type": "application/json",
                       "Authorization": "Bearer " + apiKey]
        let data = ["model": "text-davinci-003",
                    "prompt": "you are a word scanner that will scan an array and give me words from that array based on a category. here is the array of words\(userGuesses), and this is the category \(category)",
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
                        self.chatMessage = text
                        print(self.chatMessage)
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
