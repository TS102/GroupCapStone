//
//  guessesTableViewCell.swift
//  Q'Hoot
//
//  Created by Tyler Sun on 4/25/23.
//

import UIKit



class guessesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var guessesTextfield: UITextField!
    
    var delegate: GuessesTableViewCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        guessesTextfield.placeholder = "Enter guess"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func guessesMade(tableView: UITableView) {
//        guard let guesses = guessesTextfield.text else { return }
//        userguesses.append(guesses)
//        tableView.reloadData()
//    }
    

    @IBAction func buttonTapped(_ sender: UITableView) {
        guard let guesses = guessesTextfield.text else { return }
        delegate?.guessesMade(guess: guesses)
    }
}
