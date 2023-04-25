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
class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var teamPickerData: String = ""
    var timeLimitData: String = ""
    var categoryData: String = ""
    
        
    @IBOutlet var tableview: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
print("\(teamPickerData) \(timeLimitData) \(categoryData)")
        // Do any additional setup after loading the view.
        //navigationController?.title = "\(selectedCategory)"
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return guessesTableViewCell(style: .default, reuseIdentifier: "Guesses")
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
