//
//  PreGameSettingsViewController.swift
//  Q'Hoot
//
//  Created by Easton Butterfield on 4/20/23.
//

import UIKit

class PreGameSettingsViewController:UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func passGameSettrings(teams: Int, timeLimit: Int, Category: String) {
        //
    }
    var teamSelected: String = "1"
    var timeLimitSelected: Int = 10
    var catergorySelected: String = "Colors"
    let teamPickerData = ["1", "2", "3"]
    let timeLimitData = [10, 20, 30]
    @IBOutlet weak var numberOfTeamsPicker: UIPickerView!
    @IBOutlet weak var timeLimitPicker: UIPickerView!
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTextField.layer.borderWidth = 1.0
        self.numberOfTeamsPicker.dataSource = self
        self.numberOfTeamsPicker.delegate = self
        self.timeLimitPicker.dataSource = self
        self.timeLimitPicker.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let white = UIColor.white
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
                categoryTextField.layer.borderColor = white.cgColor
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == numberOfTeamsPicker {
            return teamPickerData.count
        }
        else if pickerView == timeLimitPicker {
            return timeLimitData.count
        } else {return 0}
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
           {
               pickerView.setValue(UIColor.systemGray, forKeyPath: "textColor")
               
               
        if pickerView == numberOfTeamsPicker {
            return teamPickerData[row]
        }
        else if pickerView == timeLimitPicker {
            return String(timeLimitData[row])
        } else {return nil}
          }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == numberOfTeamsPicker {
            teamSelected = teamPickerData[row]
            print(teamSelected)
        }
        else if pickerView == timeLimitPicker {
            timeLimitSelected = timeLimitData[row]
            print(timeLimitSelected)
        }
    }
    func textFieldEmpty() {
        let red = UIColor.red
        UIView.animate(withDuration: 0.1) {
            self.categoryTextField.transform = CGAffineTransform(translationX: 10, y: 4.5)
            self.categoryTextField.layer.borderColor = red.cgColor
        }
        self.categoryTextField.transform = .identity
    }
    @IBAction func nextButtonPushed(_ sender: Any) {
//        guard categoryTextField.text != "" else {return}
        if categoryTextField.text == "" {
            textFieldEmpty()
        } else {
            catergorySelected = categoryTextField.text ?? "Colors"
            performSegue(withIdentifier: "startGame", sender: Any?.self)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "startGame" else {return}
            let vc = segue.destination as! GameViewController
                vc.teamPickerData = teamSelected
                vc.timeLimitData = timeLimitSelected
        vc.categoryData = catergorySelected.lowercased()
    }
    
   
}

