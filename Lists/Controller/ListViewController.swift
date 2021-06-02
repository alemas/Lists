//
//  ListViewController.swift
//  Lists
//
//  Created by Mateus Reckziegel on 01/05/21.
//

import CoreData

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CheckboxViewDelegate {
    
    @IBOutlet private var tableView: UITableView!
    
    private var newItemAlert: UIAlertController!
    var list: List!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navController = self.navigationController {
            navController.navigationBar.topItem!.title = list.name
        }
        
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ListItemTableViewCell", bundle: nil), forCellReuseIdentifier: ListItemTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK:UITableViewDataSource protocol
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ListItemTableViewCell.identifier, for: indexPath) as! ListItemTableViewCell
        let row = indexPath.row
        
        cell.lblDescription.text = self.list.itemsArray[row].itemDescription
        cell.checkboxView.isChecked = self.list.itemsArray[row].isDone
        
        return cell
    }
    
    // MARK:CheckboxViewDelegate protocol
    
    func didChangeCheckState(checkboxView: CheckboxView, isChecked: Bool) {
        
    }
    
    
    // MARK:IBActions
    
    @IBAction func addItem(_ sender: UIButton) {
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { _ in
            ListManager.newListItem(list: self.list, itemDescription: self.newItemAlert.textFields![0].text!)
            ListManager.saveContext()
            self.tableView.reloadData()
        })
        newItemAlert = UIAlertController(title: "New Item", message: "Enter a description for this item", preferredStyle: UIAlertController.Style.alert, successAction: saveAction, txtFieldPlaceholder: "Name")
        self.present(newItemAlert, animated: true, completion: nil)
    }
}
