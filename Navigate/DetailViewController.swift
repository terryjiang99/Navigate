//
//  DetailViewController.swift
//  SearchBar
//
//  Created by Shinkangsan on 1/23/17.
//  Copyright © 2017 Sheldon. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {

    //from prev controller
    var dataModel:Model!
   
    //-----------VARIABLES---------------------
   
    //IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var partAdded: UILabel!
   // @IBOutlet weak var dateTF: UITextField!
    
    let datePicked = UIDatePicker()
    
    @IBOutlet weak var dateTF: UITextField!
    
    
    //-------- DATE FUNCTION ------------------
    
    func createDate(){
        //format date displayed
        datePicked.datePickerMode = .date
        //assign our text feld to the date picker
        dateTF.inputView = datePicked
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //add a finished button to toolbar
        let finishedButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector (buttonClick))
        toolbar.setItems([finishedButton], animated: true)
        dateTF.inputAccessoryView = toolbar
    }
    
    func buttonClick(){
        //format date
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        dateFormat.timeStyle = .none
        dateTF.text = dateFormat.string(from: datePicked.date)
        self.view.endEditing(true)
        
    }
    
    //-------- ADD TO INVENTORY BUTTON -------
    @IBAction func invList(_ sender: UIButton) {
        // get current user id
        let user = Auth.auth().currentUser?.uid
        // add part to current user's inventory
        self.dbref?.child("Users").child(user!).child("repairs").childByAutoId().setValue(imageNameLabel.text)
        // show part added message
        self.partAdded.isHidden = false
        GlobalVariable.inventoryList.append(imageNameLabel.text!)
       
 //---- ADD TO CGRect ARRAY AND MAKES SURE THERE IS NO DUPLICATES (TEMPORARY SOLUTION) --------------------------
        if (imageNameLabel.text == "img026"){
            if !(GlobalVariable.car1.contains(CGRect(x:50, y: 50, width:50, height:50))) {
                GlobalVariable.car1.append(CGRect(x: 50, y: 50, width: 50, height: 50))
            }
        }
        else if (imageNameLabel.text == "img119"){
            if !(GlobalVariable.car1.contains(CGRect(x: 340, y: 60, width: 40, height: 40))) {
                GlobalVariable.car1.append(CGRect(x: 340, y: 60, width: 40, height: 40))
            }
        }
        else if (imageNameLabel.text == "img006"){
            if !(GlobalVariable.car1.contains(CGRect(x: 170, y: 90, width: 50, height: 40))) {
                GlobalVariable.car1.append(CGRect(x: 170, y: 90, width: 50, height: 40))
            }
        }
        else if (imageNameLabel.text == "img227"){
            if !(GlobalVariable.car1.contains(CGRect(x: 270, y: 60, width: 20, height: 20))) {
                GlobalVariable.car1.append(CGRect(x: 270, y: 60, width: 20, height: 20))
            }
        }
        else if (imageNameLabel.text == "img058"){
            if !(GlobalVariable.car1.contains(CGRect(x: 120, y: 85, width: 40, height: 20))) {
                GlobalVariable.car1.append(CGRect(x: 120, y: 85, width: 40, height: 20))
            }
        }
        //--------------------------------------------------------------------------------
        //--------------This will reload the main page again----------------
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desViewController = mainStoryBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let newFrontViewController = UINavigationController.init(rootViewController:desViewController)
        revealViewController().pushFrontViewController(newFrontViewController, animated: true)
        //------------------------------------------------------------------
    }
 
    // get Firebase reference
   var dbref: DatabaseReference?

    
//------------ MAIN --------------------
 override func viewDidLoad() {
        super.viewDidLoad()
    // get instance of firebase reference
     dbref = Database.database().reference()

        imageNameLabel.text = dataModel.imageName
        yearLabel.text = dataModel.imageYear
        priceLabel.text = dataModel.imagePrice

     self.partAdded.isHidden = true
     partAdded.text = "Part Added!"
    
        imageView.image = UIImage(named: dataModel.imageName)
    createDate()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //--------Declaring a global variable-----------
    struct GlobalVariable{
        static var inventoryList = [String]()
        static var car1 = [CGRect]()
    }

}
