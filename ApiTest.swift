//
//  ApiTest.swift
//  Q'Hoot
//
//  Created by Tyler Sun on 4/20/23.
//

import Foundation
//        let url = URL(string: "https://api.openai.com/v1/completions")!
//        let apiKey = "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"
//        let headers = ["Content-Type": "application/json",
//                       "Authorization": "Bearer " + apiKey]
//        let data = ["model": "text-davinci-003",
//                    "prompt": "you are a word scanner that will scan an array and give me words from that array based on a category. here is the array of words\(userGuesses), and this is the category \(category)",
//                    "max_tokens": 25,
//                    "temperature": 0.2
//        ] as [String : Any]
//        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: [])
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.allHTTPHeaderFields = headers
//        request.httpBody = jsonData
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            guard let data = data else {
//                print("Error: \(String(describing: error))")
//                return
//            }
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                if let choices = json?["choices"] as? [[String: Any]], let text = choices.first?["text"] as? String {
//                    DispatchQueue.main.async {
//                        self.chatMessage = text
//                        print(self.chatMessage)
//                        }
//                } else {
//                    print("\(String(describing: json))")
//                    //        } else {
//                    //          print("\(json)") USE THIS IF THE APP DOESNT WORK
//                }
//            } catch {
//                print("Error decoding response: \(error.localizedDescription)")
//            }
//        }.resume()
