//
//  PreGameSettingsViewController.swift
//  Q'Hoot
//
//  Created by Easton Butterfield on 4/20/23.
//

import UIKit

class PreGameSettingsViewController:UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
    
    let teamPickerData = ["1", "2", "3"]
    let timeLimitData = ["30","60", "90"]
    let categoryData = ["Colors", "Plants", "Food", "Trees"]
    @IBOutlet weak var numberOfTeamsPicker: UIPickerView!
    @IBOutlet weak var timeLimitPicker: UIPickerView!
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.numberOfTeamsPicker.dataSource = self
        self.numberOfTeamsPicker.delegate = self
        self.timeLimitPicker.dataSource = self
        self.timeLimitPicker.delegate = self
        self.categoryPicker.dataSource = self
        self.categoryPicker.delegate = self
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
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == numberOfTeamsPicker {
            return teamPickerData.count
        }
        else if pickerView == timeLimitPicker {
            return timeLimitData.count
        }
        else if pickerView == categoryPicker{
            return categoryData.count
        } else {return 0}
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
           {
        if pickerView == numberOfTeamsPicker {
            return teamPickerData[row]
        }
        else if pickerView == timeLimitPicker {
            return timeLimitData[row]
        }
        else if pickerView == categoryPicker{
            return categoryData[row]
        } else {return nil}
          }
    
    @IBAction func nextButtonPushed(_ sender: Any) {
     
        performSegue(withIdentifier: "startGame", sender: Any?.self)
    }
    
}

