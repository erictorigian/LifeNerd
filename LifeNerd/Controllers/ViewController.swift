//
//  ViewController.swift
//  LifeNerd
//
//  Created by Eric Torigian on 8/3/20.
//  Copyright © 2020 Torigian Group, LLC. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var taskList:[Task]?
    
    //Reference to the managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
       
    var enteredTask = ""

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //get items from CoreData
        fetchTask()
        
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        addNewTask()
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        //reset the database - removed this and will add something better here
    }
    
    //MARK - Functions
    func fetchTask() {
        //fetch the data from CoreData to display in tableView
        do {
            self.taskList = try context.fetch(Task.fetchRequest())
            
            //do the update on the main thread - this lets this allows the function to be called from the background
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
    
        }
        catch {
            print("Error fetching tasks from CoreData")
        }
        
    }
    
    private func addNewTask() {
        self.enteredTask = taskTextField.text!
        
        saveTask(named: self.enteredTask)
        
        self.fetchTask()
        
        taskTextField.text = ""
    }
    
    private func saveTask(named name: String) {
        let task = Task(context: self.context)
        
        task.taskName = name
        
        do {
            try self.context.save()
        }
        catch {
            print("error saving to CoreData")
        }
        
        self.fetchTask()
    }
    
        
    //MARK - tableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return taskList!.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "taskCell" )
        
        cell.textLabel?.text = "- " + (taskList?[indexPath.row].taskName!)!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            //Which task to delete
            let taskToDelete = self.taskList![indexPath.row]
            
            //remove the task
            self.context.delete(taskToDelete)
            //save the context
            do {
                try self.context.save()
            }
            catch {
                print("Error saving after delete")
            }
            
            //fetch the data
            self.fetchTask()
                       
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }

    
}

