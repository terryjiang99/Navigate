//
//  LoginViewController.swift
//  Navigate
//
//  Created by Sully Al Shemari on 2017-10-27.
//  Copyright © 2017 Dream Chasers. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    // get Firebase reference
    var dbref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbref = Database.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // user registration:
    // check for input, create user with Firebase Auth
    // if registration valid, add user to database
    // do error checking
    @IBAction func register(_ sender: Any) {
        self.errorMessage.isHidden = true
        if let em = email.text, let pass = password.text{
            Auth.auth().createUser(withEmail: em, password: pass, completion: { (user, error) in
                if let u = user{
                    let info = [
                        "email": em,
                        "password": pass,
                        "repairs": ""
                    ]
                    self.dbref?.child("Users").child(u.uid).setValue(info)
                    self.performSegue(withIdentifier: "goToHomePage", sender: self)
                }else{
                    self.errorMessage.text = "Invalid email/Password must be at least 6 characters."
                    self.errorMessage.isHidden = false
                }
            })
        }
    }
    // check for input, if valid, login and go to home page
    // do error checking
    @IBAction func login(_ sender: Any) {
        self.errorMessage.isHidden = true
        if let em = email.text, let pass = password.text{
            Auth.auth().signIn(withEmail: em, password: pass, completion: { (user, error) in
                if let u = user{
                    self.performSegue(withIdentifier: "goToHomePage", sender: self)
                }else{
                    self.errorMessage.text = "Invalid email or password"
                    self.errorMessage.isHidden = false
                }
            })
        }
    }
    // hide keyboard on touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        email.resignFirstResponder()
        password.resignFirstResponder()
    }

}
