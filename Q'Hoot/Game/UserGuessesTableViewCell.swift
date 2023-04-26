//
//  UserGuessesTableViewCell.swift
//  Q'Hoot
//
//  Created by Tyler Sun on 4/25/23.
//

import UIKit

class UserGuessesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var usersGuessesLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with label: String) {
        usersGuessesLabel.text = label
    }
}
