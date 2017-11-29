//
//  settingsViewController.swift
//  Navigate
//
//  Created by Sully Al Shemari on 2017-10-24.
//  Copyright © 2017 Dream Chasers. All rights reserved.
//

import UIKit
import UserNotifications
class settingsViewController: UIViewController {

    
    @IBOutlet weak var fname: UITextField!
    
    @IBOutlet weak var lname: UITextField!
    
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var sex: UITextField!
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var theSwitch: UISwitch!
    
    let datePicked = UIDatePicker()
    
   // @IBOutlet weak var dateTF: UITextField!
    
    
    //-------- DATE FUNCTION ------------------
    
    func createDate(){
        //format date displayed
        datePicked.datePickerMode = .date
        //assign our text feld to the date picker
        age.inputView = datePicked
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //add a finished button to toolbar
        let finishedButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector (buttonClick))
        toolbar.setItems([finishedButton], animated: true)
        age.inputAccessoryView = toolbar
    }
    
    func buttonClick(){
        //format date
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        dateFormat.timeStyle = .none
        age.text = dateFormat.string(from: datePicked.date)
        self.view.endEditing(true)
        
    }
    
    
    
    @IBAction func onOffSwitch(_ sender: Any) {
        if theSwitch.isOn{
            let content = UNMutableNotificationContent()
            content.title = "Navigate"
            content.subtitle = "Notification Settings"
            content.body = "Push Notifictions are On"
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3,repeats: false )
            
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        }
        else{
            let content = UNMutableNotificationContent()
            content.title = "Navigate"
            content.subtitle = "Notification Settings"
            content.body = "Push Notifictions are Off"
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3,repeats: false )
            
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.target = revealViewController()
        menuBtn.action = #selector(SWRevealViewController.rightRevealToggle(_:))
        // Do any additional setup after loading the view.
        createDate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fname.resignFirstResponder()
        lname.resignFirstResponder()
        age.resignFirstResponder()
        sex.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
