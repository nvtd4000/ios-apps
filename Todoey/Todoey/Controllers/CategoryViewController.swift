//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Dung Nguyen on 2/21/19.
//  Copyright © 2019 dapp. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift
import ChameleonFramework


class CategoryViewController: SwipeTableViewController {//UITableViewController {
    
    let realm = try! Realm()
    
    //var categoryArray = [Category]()
    var categories : Results<Category>?
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //file path
//        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
//        print(dataFilePath)
//        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//        print(paths[0])
//
        loadCategories()
        tableView.separatorStyle = .none
        
        
    }

   

    //MARK: - TableView Datasource methods
    
    //MARK: - TableView Delegate Methods
    
    //MARK: Data Manipulation Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //categories not nil -> return count
        //           is nill  -> return 1
        return categories?.count ?? 1;
    }
    
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
//        cell.textLabel?.text = categories?[indexPath.row].name ?? "no Category added yet"
//
//
//        return cell;
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! SwipeTableViewCell
//        cell.delegate = self
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row]{
            cell.textLabel?.text = category.name //?? "no Category added yet"
            
            guard let categoryColor = UIColor(hexString: category.color) else {fatalError()}
            
            //cell.backgroundColor = UIColor(hexString: category.color ?? "1D9BF6")
            cell.backgroundColor = categoryColor
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
   
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default){
            (action) in
           
            //let newCategory = Category(context: self.context)
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat.hexValue()
            //self.categories.append(newCategory)
            self.save(category: newCategory)
            
        }
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func save(category: Category){
        //        let encoder = PropertyListEncoder()
        
        do{
            //            let data = try encoder.encode(self.itemArray)
            //            try data.write(to: self.dataFilePath!)
            
            //Core data
            //try context.save();
            try realm.write{
                realm.add(category)
            }
            
        } catch{
            //            print("Error encoding item array, \(error)")
            print("Error saving context, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
   
    
//    func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()){
//        //let request : NSFetchRequest<Item> = Item.fetchRequest()
//        do {
//            categoryArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//
//        tableView.reloadData()
//    }

    func loadCategories(){
        
        categories = realm.objects(Category.self)
       
        
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
           if let categoryForDeletion = self.categories?[indexPath.row]{
              do{
                  try self.realm.write{
                    self.realm.delete(categoryForDeletion)
                  }
               } catch{
                    print("Error deleting category, \(error)")
               }
            
                            //tableView.reloadData()
            }
        
       
    }
}

//MARK: - SwipeTableViewCellDelegate

//extension CategoryViewController: SwipeTableViewCellDelegate{
//
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else { return nil }
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
//            // handle action by updating model with deletion
//
//            if let categoryForDeletion = self.categories?[indexPath.row]{
//                do{
//                    try self.realm.write{
//                        self.realm.delete(categoryForDeletion)
//                    }
//
//                } catch{
//                    //            print("Error encoding item array, \(error)")
//                    print("Error deleting category, \(error)")
//                }
//
//                //tableView.reloadData()
//            }
//
//        }
//
//        // customize the action appearance
//        deleteAction.image = UIImage(named: "delete-icon")
//
//        return [deleteAction]
//    }
//
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
//        //options.transitionStyle = .border
//        return options
//    }
//
//
//}
