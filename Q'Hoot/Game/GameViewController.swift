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
    
    

    var teamPickerData: String = ""
    var timeLimitData: String = ""
    var categoryData: String = ""
    
    // this is where the guesses will go when the user makes them
    var userGuesses: [String] = []
    
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet var tableview: UITableView!
   

    override func viewDidLoad() {
        print(userGuesses)
        super.viewDidLoad()
        tableview.reloadData()
        tableview.delegate = self
        tableview.dataSource = self
print("\(teamPickerData) \(timeLimitData) \(categoryData)")
        promptLabel.text = "Write as many words that fall into the \(categoryData) category as you can in \(timeLimitData) seconds!"
      
        // Do any additional setup after loading the view.
        //navigationController?.title = "\(selectedCategory)"
    }
    
    
    func guessesMade(guess: String) {
        userGuesses.insert(guess, at: 0)
        tableview.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return userGuesses.count
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
            let guess = userGuesses[indexPath.row]
            cell.update(with: guess)
            print(userGuesses)
            
            return cell
        }
        
//        return UITableViewCell.init(style: .default, reuseIdentifier: nil)
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
