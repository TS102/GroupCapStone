//
//  PlayViewController.swift
//  Q'Hoot
//
//  Created by Steven Newman on 4/17/23.
//

import UIKit

class PlayViewController: UIViewController, ResultsViewControllerDelegate {
    
    @IBOutlet weak var previousGameLabel: UILabel!
    @IBOutlet weak var chatLabel: UILabel!
    
    
    
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
        if amountOfTeams == 0 {
            previousGameLabel.isHidden = true
            chatLabel.isHidden = true
        } else {
            previousGameLabel.isHidden = false
            chatLabel.isHidden = false
        }
    }
    
    
    func sendData(team1: [String], team2: [String], team3: [String], numberOfTeams: Int, chatRespone: String) {
        amountOfTeams = numberOfTeams
        hideLabels()
        chatLabel.text = chatRespone
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


