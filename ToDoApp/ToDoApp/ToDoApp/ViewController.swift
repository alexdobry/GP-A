//
//  ViewController.swift
//  ToDoApp
//
//  Created by Alex on 12.11.14.
//  Copyright (c) 2014 Alex Dobrynin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return toDoService.entries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "nil")
        cell.textLabel.text = toDoService.entries[indexPath.row].title
        cell.detailTextLabel?.text = toDoService.entries[indexPath.row].description
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            toDoService.entries.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }

    @IBAction func addButton(sender: UIBarButtonItem) {
        var titleField:UITextField!
        var descriptionField:UITextField!
        
        var alert = UIAlertController(title: "Neuer Eintrag", message: "Title und Beschreibung eingeben", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler { (textfield: UITextField!) in
            textfield.placeholder = "Title eingeben"
            titleField = textfield
        }
        alert.addTextFieldWithConfigurationHandler { (textfield: UITextField!) in
            textfield.placeholder = "Beschreibung eingeben"
            descriptionField = textfield
        }
        /*alert.addAction(UIAlertAction(title: "Hinzufügen", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) in
            toDoService.addEntry(titleField.text, description: descriptionField.text)
            self.table.reloadData()
        }))*/
        
        alert.addAction(UIAlertAction(title: "Hinzufügen", style: UIAlertActionStyle.Default, handler: addEntry));
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func addEntry(action: UIAlertAction!) {
        toDoService.addEntry("title", description: "description")
        self.table.reloadData()
    }
}

