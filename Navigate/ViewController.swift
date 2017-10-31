//
//  ViewController.swift
//  RIghtSideMenuOpen
//
//  Created by Parth Changela on 13/11/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    let WIDTHSIZE = UIScreen.main.bounds.width * 0.85   //peak width for add parts or settings
    //---------------IBOUTLETS---------------------------------------------------------
    
    @IBOutlet weak var car: UIImageView!
    
    @IBOutlet weak var addParts: UIBarButtonItem!
    @IBOutlet weak var btnMenuOpen: UIBarButtonItem!
    
   // @IBOutlet weak var scrollView: UIScrollView!
    
    //--------------VARIABLES----------------------------------------------------------
    
    var dbref: DatabaseReference? //FIREBASE Terry

    var imageArr = [UIImage]()  // swipe images for main page
    
    var data = [String]() //Inventory list
    var rectList = [CGRect]()
    
    
    //-----------------------------MAIN------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        //Stored array is receiving to populate inventory list is being accessed from DetailViewController variable called inventory list (global variable)
        data = DetailViewController.GlobalVariable.inventoryList
        rectList = DetailViewController.GlobalVariable.car1
        //------------------Reference to database -Terry-------------------------------
        dbref = Database.database().reference()

        
        //-------------------Swipe pics -Sully-----------------------------------------
        /*scrollView.frame = view.frame
        imageArr = [#imageLiteral(resourceName: "CarParts"), #imageLiteral(resourceName: "carSideView")]
        for i in 0..<imageArr.count{
            let imageView = UIImageView()
            imageView.image = imageArr[i]
            imageView.contentMode = .scaleAspectFit
            let xPos = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.width)
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i + 1)
            scrollView.addSubview(imageView)
            
        }*/

        cut(hole: rectList)
        sideMenus()
        customizeNavBar()
        
        //----------------Right View load --------------------------------------------
        // Do any additional setup after loading the view, typically from a nib.
        revealViewController().rightViewRevealWidth = 250
        btnMenuOpen.target = revealViewController()
        btnMenuOpen.action = #selector(SWRevealViewController.rightRevealToggle(_:))

    }
    
   
    
    //----------------------------SWIPE SIDE MENUS------------------------------------
    func sideMenus(){
        if revealViewController() != nil {
            
            addParts.target = revealViewController()
            addParts.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = WIDTHSIZE //constant declared at top
            revealViewController().rightViewRevealWidth = WIDTHSIZE //constant declared at top
          
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    
    
    //---------------CREATE PARTS OF GREEN IMAGES CORRESPONDING TO ADDED PARTS------------------
     func cut(hole: [CGRect]){
        let p:CGMutablePath = CGMutablePath()
        p.addRect(car.bounds)
        for ho in hole{
            p.addRect(ho)
        }
        let s = CAShapeLayer()
        s.path = p
        s.fillRule = kCAFillRuleEvenOdd
        car.layer.mask = s
    }
    
    //--------------------CUSTOMIZE COLOUR MENU BAR --------------------------------
    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green:255/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 0, green:0/255, blue: 0/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    //--------------------SETUP TABLEVIEW CELL --------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
        
        // -CHECKS IF ELEMENT DELETED IS THE LAST ELEMENT AND THEN DELETES THE RECTANGLE CORRESPONDING (TEMPORARY SOLUTION)-
            
            //Get the string we are trying to delete
            let test = DetailViewController.GlobalVariable.inventoryList[indexPath.row]
            
            //Remove the string from the table
            DetailViewController.GlobalVariable.inventoryList.remove(at: indexPath.row)
            data.remove(at: indexPath.row)
            
            //Check if table still contains the string, if it does dont remove the green corresponging part
            if data.contains(test) {
                print("DO NOTHING")
            }
            //Otherwise check which part we are trying to remove
            else{
                if test == "battery" {
                    //Go through the CGrect array, find the corresponding part and remove (applies to the other else if statments too)
                    for rect in rectList{
                        if rect.equalTo(CGRect(x:50, y: 50, width:50, height:50)){
                            let index = rectList.index(of: rect)
                            rectList.remove(at: index!)
                            DetailViewController.GlobalVariable.car1.remove(at: index!)
                        }
                    }
                }
                else if test == "breakPads" {
                    for rect in rectList{
                        if rect.equalTo(CGRect(x: 340, y: 60, width: 40, height: 40)){
                            let index = rectList.index(of: rect)
                            rectList.remove(at: index!)
                            DetailViewController.GlobalVariable.car1.remove(at: index!)
                        }
                    }
                }
                else if test == "tire" {
                    for rect in rectList{
                        if rect.equalTo(CGRect(x: 170, y: 90, width: 50, height: 40)){
                            let index = rectList.index(of: rect)
                            rectList.remove(at: index!)
                            DetailViewController.GlobalVariable.car1.remove(at: index!)
                        }
                    }
                }
                else if test == "muffler" {
                    for rect in rectList{
                        if rect.equalTo(CGRect(x: 270, y: 60, width: 20, height: 20)){
                            let index = rectList.index(of: rect)
                            rectList.remove(at: index!)
                            DetailViewController.GlobalVariable.car1.remove(at: index!)
                        }
                    }
                }
                else if test == "sparkPlug" {
                    for rect in rectList{
                        if rect.equalTo(CGRect(x: 120, y: 85, width: 40, height: 20)){
                            let index = rectList.index(of: rect)
                            rectList.remove(at: index!)
                            DetailViewController.GlobalVariable.car1.remove(at: index!)
                        }
                    }
                }
            }
            //create the new green image
            cut(hole: rectList)
            //reset the table
            tableView.reloadData()
        }
    }

    
    //-------- DO NOT DELETE - DEFAULT MEMORY ALLOCATION ---------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

