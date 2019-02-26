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

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    //var categoryArray = [Category]()
    var categories : Results<Category>?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //file path
//        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
//        print(dataFilePath)
//        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//        print(paths[0])
//
        loadCategories()
        
    }

   

    //MARK: - TableView Datasource methods
    
    //MARK: - TableView Delegate Methods
    
    //MARK: Data Manipulation Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //categories not nil -> return count
        //           is nill  -> return 1
        return categories?.count ?? 1;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "no Category added yet"
        
        
        return cell;
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
           
            //self.categoryArray.append(newCategory)
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
        
        let categories = realm.objects(Category.self)
       
        
        tableView.reloadData()
    }
}
