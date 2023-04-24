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
class GameViewController: UIViewController {
    var teamPickerData: String = ""
    var timeLimitData: String = ""
    var categoryData: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
print("\(teamPickerData) \(timeLimitData) \(categoryData)")
        // Do any additional setup after loading the view.
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
