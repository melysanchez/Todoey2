//
//  ViewController.swift
//  Todoey2
//
//  Created by Katherynne Hidalgo on 10/11/19.
//  Copyright © 2019 Katherynne H. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Find Mike", "Buy Eggos", "Destory Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK - Tableview DataSource Methods
       
       
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return itemArray.count
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
          let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
           
           cell.textLabel?.text = itemArray[indexPath.row]
           
           return cell
       }
      
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let cellselected = itemArray[indexPath.item]
//         let cellselected = itemArray[indexPath.row]
//        print("celda seleccionada : \(cellselected)")
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

