//
//  ViewController.swift
//  LifeNerd
//
//  Created by Eric Torigian on 8/3/20.
//  Copyright © 2020 Torigian Group, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var taskList = Task.fetchAll()
    
    var enteredTask = ""

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        addNewTask()
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        deleteAllTask()
    }
    
    
    private func addNewTask() {
        self.enteredTask = taskTextField.text!
        
        saveTask(named: self.enteredTask)
        
        self.taskList = Task.fetchAll()
        
        tableView.reloadData()
        
        taskTextField.text = ""
    }
    
    private func saveTask(named name: String) {
        let task = Task(context: AppDelegate.viewContext)
        
        task.taskName = name
        
        try? AppDelegate.viewContext.save()
    }
    
    private func deleteAllTask() {
        Task.deleteAll()
        
        taskList = Task.fetchAll()
        
        tableView.reloadData()
    }
    
    //MARK - tableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return taskList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "taskCell" )
        
        cell.textLabel?.text = "- " + taskList[indexPath.row].taskName!
        
        return cell
    }

    
}

