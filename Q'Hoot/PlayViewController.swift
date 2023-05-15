//
//  PlayViewController.swift
//  Q'Hoot
//
//  Created by Steven Newman on 4/17/23.
//

import UIKit

class PlayViewController: UIViewController, ResultsViewControllerDelegate {
    
    @IBOutlet weak var previousGameLabel: UILabel!
    
    @IBOutlet var previousGuesses: [UILabel]!
    
    var amountOfTeams = 0
    var team1Guesses: [String] = []
    var team2Guesses: [String] = []
    var team3Guesses: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print(team1Guesses)
        print(amountOfTeams)
        
        hideLabels()
    }
    
    func hideLabels() {
        switch amountOfTeams {
        case 0:
            previousGameLabel.isHidden = true
            previousGuesses[0].isHidden = true
            previousGuesses[1].isHidden = true
            previousGuesses[2].isHidden = true
        case 1:
            previousGameLabel.isHidden = false
            previousGuesses[0].isHidden = false
            previousGuesses[1].isHidden = true
            previousGuesses[2].isHidden = true
        case 2:
            previousGameLabel.isHidden = false
            previousGuesses[0].isHidden = false
            previousGuesses[1].isHidden = false
            previousGuesses[2].isHidden = true
        case 3:
            previousGameLabel.isHidden = false
            previousGuesses[0].isHidden = false
            previousGuesses[1].isHidden = false
            previousGuesses[2].isHidden = false
        default:
            print("should never hit")
        }
    }
    
    
    func sendData(team1: [String], team2: [String], team3: [String], numberOfTeams: Int, ishidden: Bool?) {
//        team1Guesses = team1
//        team3Guesses = team2
//        team3Guesses = team3
        amountOfTeams = numberOfTeams
        hideLabels()
        previousGuesses[0].text = team1.joined(separator: ", ")
        previousGuesses[1].text = team2.joined(separator: ", ")
        previousGuesses[2].text = team3.joined(separator: ", ")
        
        print(amountOfTeams)
    }
    
    @IBAction func unwind(_ unwindSegue: UIStoryboardSegue) {
        let source = unwindSegue.source as? ResultsViewController
        
        source?.delegate = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "startGame" else {return}
//            let vc = segue.destination as! PreGameSettingsViewController
//        vc.delegate = self
//        }
    
}


