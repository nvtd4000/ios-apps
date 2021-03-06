//
//  ViewController.swift
//  Todoey
//
//  Created by Dung Nguyen on 2/10/19.
//  Copyright © 2019 dapp. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift
import ChameleonFramework

class ToDoListViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var searchBar: UISearchBar!
    var todoItems : Results<Item>?
    var selectedCategory: Category? {
        didSet{
           loadItems()
        }
    }
    //var defaults = UserDefaults()
    
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
//    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //file path
//        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
//        print(dataFilePath)
//        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//        print(paths[0])
        // Do any additional setup after loading the view, typically from a nib.
        //print(paths[0])
//        let newItem = Item()
//        newItem.title = "todo 1"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "todo 2"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "todo 3"
//        itemArray.append(newItem3)
        
        //loadItems(with: Item.fetchRequest())
        loadItems()
        
        tableView.separatorStyle = .none
        
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = items
//        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //navigationController?.navigationBar.barTintColor = UIColor(hexString: colorHex)
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist")}
        
        guard let colorHex = selectedCategory?.color else { fatalError()}
        
        title = selectedCategory?.name
        
        
        guard let navBarColor = UIColor(hexString: colorHex) else{fatalError()}
            
        
        navBar.barTintColor = UIColor(hexString: colorHex)
        searchBar.barTintColor = UIColor(hexString: colorHex)
        navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarColor, returnFlat: true)]
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "1D9BF6")
        navigationController?.navigationBar.tintColor = FlatWhite()
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: FlatWhite()]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1;
    }
    
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = super.tableView(tableView, cellForRowAt: indexPath)
//
//
//        cell.accessoryType = todoItems[indexPath.row].done ? .checkmark : .none
//
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            if let color = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItems!.count)){
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            }
            
            
            
            cell.accessoryType = item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No Item Added"
            
        }
        
//        if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //itemArray[indexPath.row].setValue("Completed", forKey: "title")
        //print(indexPath.row)
        
        //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        
        
//        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
//
//         saveItems()
        
        
        
        
         //tableView.reloadData()
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//            itemArray[indexPath.row].done = false
//        }else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//            itemArray[indexPath.row].done = true
//        }
        
        if let item = todoItems?[indexPath.row]{
            do{
                try self.realm.write{
                   //realm.delete(item)
                    item.done = !item.done
                }
            } catch{
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todo item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){
            (action) in
//            let newItem = Item()
//            newItem.title = textField.text!
//
//            self.itemArray.append(newItem)
//            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
//            self.saveItems()
            
            //Core data
            if let currentCategory = self.selectedCategory {
                do{
                    try self.realm.write{
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch{
                    print("Error saving new Items, \(error)")
                }
               
            }
            
            
           self.tableView.reloadData()
            //self.saveItems()
            
        }
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
//    func saveItems(){
////        let encoder = PropertyListEncoder()
//
//        do{
////            let data = try encoder.encode(self.itemArray)
////            try data.write(to: self.dataFilePath!)
//
//            //Core data
//            try context.save();
//        } catch{
////            print("Error encoding item array, \(error)")
//            print("Error saving context, \(error)")
//        }
//
//        self.tableView.reloadData()
//    }
    
//    func loadItems(){
//
//        if let data = try? Data(contentsOf: dataFilePath!){
//            let decoder = PropertyListDecoder()
//            do{
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch{
//                print("Error decoding item array, \(error)")
//            }
//        }
//
//
//    }
    
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
//        //let request : NSFetchRequest<Item> = Item.fetchRequest()
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@ ", selectedCategory!.name!)
//        if let addPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,predicate!])
//        }else{
//            request.predicate = categoryPredicate
//        }
//
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//
//         tableView.reloadData()
//    }
    
    func loadItems(){
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
       
        
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write {
                    realm.delete(item)
                }
            }catch {
                print("Error in deleting item, \(error)")
            }
            
        }
    }
}
//MARK: -SearchBar methods

extension ToDoListViewController: UISearchBarDelegate{ 
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.predicate = predicate
//
//        let sortDescription = NSSortDescriptor(key: "title", ascending: true)
//        request.sortDescriptors = [sortDescription]
        
//        do{
//            itemArray = try context.fetch(request)
//        }catch {
//            print("Error fetching data from context \(error)")
//        }
        
//        loadItems(with: request)
       tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            print("searchBar empty")
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    
}

