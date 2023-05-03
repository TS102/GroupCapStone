//
//  GameViewController.swift
//  Q'Hoot
//
//  Created by Easton Butterfield on 4/21/23.
//

import UIKit

protocol PreGameSettings {
func passGameSettrings(teams: Int, timeLimit: Int, Category: String)
}

protocol GuessesTableViewCellDelegate {
    func guessesMade(guess: String)
}

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GuessesTableViewCellDelegate  {
    var currentTeam: Int = 1
    var gamesOver: Bool = false
    var teamPickerData: String = ""
    var timeLimitData: Int = 5
    var categoryData: String = ""
    // this is where the guesses will go when the user makes them

    var team1Guesses: [String] = []
    var team2Guesses: [String] = []
    var team3Guesses: [String] = []
    var seconds: Int = 30
    var userGuesses: [String] = []
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet var tableview: UITableView!
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.reloadData()
        seconds = timeLimitData
print("\(teamPickerData) \(timeLimitData) \(categoryData)")
        print(team1Guesses)
        promptLabel.text = "Write as many words that fall into the \(categoryData) category as you can in \(timeLimitData) seconds!"
      
        showAlert()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
       }

    func showAlert() {
        let gamePrompt = UIAlertController(title: "Write as many words that fall into the \(categoryData) category as you can in \(timeLimitData) seconds!", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Go!", style: .default) { (action) in
            self.startTimer()
        }
        
        gamePrompt.addAction(action)
        
        present(gamePrompt, animated: true, completion: nil)
    }
    
       @objc func keyboardWillShow(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
               if self.view.frame.origin.y == 0 {
                   self.view.frame.origin.y -= keyboardSize.height
               }
           }
       }

       @objc func keyboardWillHide(notification: NSNotification) {
           if self.view.frame.origin.y != 0 {
               self.view.frame.origin.y = 0
           }
       }
    
    
    func guessesMade(guess: String) {
        if currentTeam == 1 {
            team1Guesses.insert(guess, at: 0)
            tableview.reloadSections(.init(integer: 1), with: .automatic)
        } else if currentTeam == 2 {
            team2Guesses.insert(guess, at: 0)
            tableview.reloadSections(.init(integer: 1), with: .automatic)
        } else if currentTeam == 3 {
            team3Guesses.insert(guess, at: 0)
            tableview.reloadSections(.init(integer: 1), with: .automatic)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if currentTeam == 1 {
            return team1Guesses.count
        } else if currentTeam == 2 {
            return team2Guesses.count
        } else {
            return team3Guesses.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Guesses", for: indexPath) as! guessesTableViewCell
            
            // let guesses = cell.userguesses
            cell.delegate = self
            // print(guesses)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserGuesses", for: indexPath) as! UserGuessesTableViewCell
            if currentTeam == 1 {
                let guess = team1Guesses[indexPath.row]
                cell.update(with: guess)
                return cell
            } else if currentTeam == 2 {
                let guess = team2Guesses[indexPath.row]
                cell.update(with: guess)
                return cell
            } else {
                let guess = team3Guesses[indexPath.row]
                cell.update(with: guess)
                return cell
            }
        }
    }


    @objc func updateTimer() {
        if seconds > 0 {
            seconds -= 1
            timerLabel.text = "\(seconds)"
        } else {
            stopTimer()
            teams()
        }
    }

    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func teams() {
        guard let teamsCount = Int(teamPickerData) else { return }
        if teamsCount != currentTeam {
            currentTeam += 1
            tableview.reloadData()
            seconds = timeLimitData
            showAlert()
        } else if teamsCount == currentTeam {
            performSegue(withIdentifier: "Results", sender: Any?.self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Results" else {return}
            let vc = segue.destination as! ResultsViewController
        vc.category = categoryData
        vc.team1Guesses = team1Guesses
        vc.team2Guesses = team2Guesses
        vc.team3Guesses = team3Guesses
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
//
//import SwiftUI
//
//struct GameViewControllerRepresentable: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> GameViewController {
//        UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
//    }
//
//    func updateUIViewController(_ uiViewController: GameViewController, context: Context) { }
//}
//
//struct GameViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        GameViewControllerRepresentable()
//    }
//}
