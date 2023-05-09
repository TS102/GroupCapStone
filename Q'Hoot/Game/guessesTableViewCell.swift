//
//  guessesTableViewCell.swift
//  Q'Hoot
//
//  Created by Tyler Sun on 4/25/23.
//

import UIKit



class guessesTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    
    @IBOutlet weak var guessesTextfield: UITextField!
    
    var delegate: GuessesTableViewCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        guessesTextfield.delegate = self
       // guessesTextfield.addTarget(self, action: #selector(enterPressed), for: .editingDidEndOnExit)
      //  guessesTextfield.addTarget(self, action: #selector(enterPressed), for: .primaryActionTriggered)
        guessesTextfield.placeholder = "Enter guess"
    }
    

    
//    @objc func enterPressed(){
//
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let guesses = guessesTextfield.text else { return false }
        delegate?.guessesMade(guess: guesses)
        guessesTextfield.text = ""
       // Clear the text field

   
         return false
      }
//    func guessesMade(tableView: UITableView) {
//        guard let guesses = guessesTextfield.text else { return }
//        userguesses.append(guesses)
//        tableView.reloadData()
//    }
    

    @IBAction func buttonTapped(_ sender: UITableView) {
        guard let guesses = guessesTextfield.text else { return }
        delegate?.guessesMade(guess: guesses)
        guessesTextfield.text = ""
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guessesTextfield.text = ""
    }
}
