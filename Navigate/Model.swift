//
//  Model.swift
//  SearchBar
//
//  Created by Shinkangsan on 12/20/16.
//  Copyright © 2016 Sheldon. All rights reserved.
//

import UIKit
import Firebase

class Model: NSObject {
    var imageName:String = ""
    var imageYear:String = ""
    var imagePrice:String = ""
    
    init(name:String,year:String,price:String) {
        self.imageName = name
        self.imageYear = year
        self.imagePrice = price
    }
    
//Note, the name MUST match the picture name from the Assets.xcassets folder, or else it will not populate.
    
    class func generateModelArray() -> [Model]{
        //var dbref: DatabaseReference?
        //dbref = Database.database().reference()

        var modelAry = [Model]()
        /*dbref?.child("Parts").observe(.childAdded, with: { (snapshot) in
            //let partkey = snapshot.value as? [String:AnyObject]
            /*for part in (snapshot.children){
                let partName = snapshot.key
                for info in partName.children{
                    
                }
            }
            //let partName = snapshot.key
            let partPrice = snapshot.
            let partYear = snapshot.value(forKey: "year") as! String*/
            let partName = snapshot.key
            modelAry.append(Model(name: partName, year: "partYear", price: "partPrice"))
        })*/
        
        modelAry.append(Model(name: "img010", year: "2-3", price: "175 - 300"))
        modelAry.append(Model(name: "img049", year: "3-5", price: "75 - 150"))
        modelAry.append(Model(name: "img114", year: "2-4", price: "5 - 25"))
        modelAry.append(Model(name: "img164", year: "3-5", price: "75 - 125"))
        modelAry.append(Model(name: "img173", year: "2-4", price: "50 - 100"))
        modelAry.append(Model(name: "img174", year: "3-5", price: "75 - 150"))
        modelAry.append(Model(name: "img179", year: "2-4", price: "5 - 25"))
        modelAry.append(Model(name: "img210", year: "3-5", price: "75 - 125"))
        modelAry.append(Model(name: "img212", year: "2-4", price: "50 - 100"))
        modelAry.append(Model(name: "img223", year: "3-5", price: "75 - 150"))
        modelAry.append(Model(name: "img226", year: "2-4", price: "5 - 25"))
        modelAry.append(Model(name: "img230", year: "3-5", price: "75 - 125"))
        modelAry.append(Model(name: "img247", year: "2-4", price: "50 - 100"))
        
        
        
        
        
        return modelAry
    }
}
