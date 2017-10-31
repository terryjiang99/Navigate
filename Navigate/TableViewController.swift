//
//  TableViewController.swift
//  SearchBar
//
//  Created by Shinkangsan on 12/20/16.
//  Copyright © 2016 Sheldon. All rights reserved.
//

import UIKit

let WIDTHSIZE = UIScreen.main.bounds.width * 0.85

enum selectedScope:Int {
    case name = 0
    case year = 1
    case price = 2
}

class TableViewController: UITableViewController, UISearchBarDelegate{

    let initialDataAry:[Model] = Model.generateModelArray()
    var dataAry:[Model] = Model.generateModelArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBarSetup()
    }

    func searchBarSetup() {
        let searchBar = UISearchBar(frame: CGRect(x:CGFloat(0),y:CGFloat(0),width: CGFloat(WIDTHSIZE),height:CGFloat(70)))

       
        
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Name","Year","Price"]
        searchBar.selectedScopeButtonIndex = 0
        searchBar.delegate = self
 
        self.tableView.tableHeaderView = searchBar
        //self.navigationItem.titleView = searchBar
    }
    

    
    // MARK: - search bar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            dataAry = initialDataAry
            self.tableView.reloadData()
        }else {
            filterTableView(ind: searchBar.selectedScopeButtonIndex, text: searchText)
        }
    }
    
    func filterTableView(ind:Int,text:String) {
        switch ind {
            case selectedScope.name.rawValue:
                //fix of not searching when backspacing
                dataAry = initialDataAry.filter({ (mod) -> Bool in
                    return mod.imageName.lowercased().contains(text.lowercased())
                })
                self.tableView.reloadData()
            case selectedScope.year.rawValue:
                //fix of not searching when backspacing
                dataAry = initialDataAry.filter({ (mod) -> Bool in
                    return mod.imageYear.lowercased().contains(text.lowercased())
                })
                self.tableView.reloadData()
            case selectedScope.price.rawValue:
                //fix of not searching when backspacing
                dataAry = initialDataAry.filter({ (mod) -> Bool in
                    return mod.imagePrice.lowercased().contains(text.lowercased())
                })
                self.tableView.reloadData()
            default:
                print("no type")
        }
    }
    
    
    
    
    // MARK: - Table view data source
    
    //---------USED TO OVERWRITE WIDTH SIZE OF THE LEFT TABLEVIEW----------
    /* reference: https://stackoverflow.com/questions/42976006/ios-how-to-set-width-of-tableview-in-tableviewcontroller
    */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        self.tableView.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(WIDTHSIZE), height: CGFloat(UIScreen.main.bounds.height))
    }
 
    //---------------------------------------------------------------------
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tableView.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(WIDTHSIZE), height: CGFloat(UIScreen.main.bounds.height))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataAry.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TableViewCell1
        
        let model = dataAry[indexPath.row]
        
        cell.nameLbl.text = model.imageName
        
        cell.imgView.image = UIImage(named: model.imageName)
        
        cell.priceLbl.text = model.imagePrice
        cell.yearLbl.text = model.imageYear
        
        
        return cell
    }

    //add delegate method for pushing to new detail controller
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.dataModel = dataAry[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    


}
