//
//  guessesTableViewCell.swift
//  Q'Hoot
//
//  Created by Tyler Sun on 4/25/23.
//

import UIKit

class guessesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var guessesTextfield: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func buttonTapped(_ sender: Any) {
        
    }
}
