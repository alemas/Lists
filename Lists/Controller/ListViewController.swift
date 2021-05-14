//
//  ListViewController.swift
//  Lists
//
//  Created by Mateus Reckziegel on 01/05/21.
//

import CoreData

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet private var tableView: UITableView!
    
    private var listItems: Array<ListItem> = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        listItems.append(ListItem(description: "Teste 0", isDone: false))
//        listItems.append(ListItem(description: "Teste 1", isDone: false))
//        listItems.append(ListItem(description: "Teste 2", isDone: false))
//        listItems.append(ListItem(description: "Teste 3 kjahlaks hfdlaks hdflaksd hflkas dhflkash dflkasjh dflkash dflkas hdflkas hdflkadfs", isDone: false))
        
        listItems.append(ListItem())
        
        if let navController = self.navigationController {
            navController.navigationBar.topItem!.title = "List"
        }
        
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ListItemTableViewCell", bundle: nil), forCellReuseIdentifier: ListItemTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK:UITableViewDataSource protocol
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ListItemTableViewCell.identifier, for: indexPath) as! ListItemTableViewCell
        let row = indexPath.row
        
        cell.lblDescription.text = self.listItems[row].description
        cell.checkboxView.isChecked = self.listItems[row].isDone
        
        return cell
    }
}
