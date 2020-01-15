//
//  ViewController.swift
//  Todoey2
//
//  Created by Katherynne Hidalgo on 10/11/19.
//  Copyright © 2019 Katherynne H. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

//    var itemArray = ["Find Mike", "Buy Eggos", "Destory Demogorgon","a","b","c","d",
//    "e","f","g","h","j","k","l","m","n","o"]
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        //delete all newItem because exist func LoadItems
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Buy Eggos"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Destroy Demogorgon"
//        itemArray.append(newItem3)
        
        loadItems()
        
        //coment for encodable func loadItems()
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = items
//        }
    }

    //MARK - Tableview DataSource Methods
       
       
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return itemArray.count
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
          let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
           
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator sintaxis
        //value = condition ? valueIfTrue:valueIfFalse
        
        cell.accessoryType = item.done == true ? .checkmark:.none
       
        return cell
       }
      
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let cellselected = itemArray[indexPath.item]
//         let cellselected = itemArray[indexPath.row]
//        print("celda seleccionada : \(cellselected)")
        
        //Oposity false or true
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            //this cratch replace with another line encoder func saveItems()
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new item"
                textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manipulation Methods
    func saveItems(){
        let encoder = PropertyListEncoder()
                 
                 do{
                     let data = try encoder.encode(itemArray)
                     try data.write(to: dataFilePath!)
                 }catch{
                     print("Error encoding item array, \(error)")
                 }
                 
                 self.tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try?  Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding item array, \(error)")
            }
        }
    }
    
}

