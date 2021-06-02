//
//  ListsViewController.swift
//  Lists
//
//  Created by Mateus Reckziegel on 02/05/21.
//

import UIKit
import CoreData

class ListsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    private lazy var btnEdit: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toggleEditMode(sender:)))
    private lazy var btnDone: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(toggleEditMode(sender:)))
    
    var persistentContainer: PersistentContainer!
    private var lists: Array<List> = []
    private var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard self.persistentContainer != nil else {
            fatalError("Persistent Container needs to be loaded")
        }
        
        dateFormatter.dateFormat = "dd/MM/YY"
        lists = ListManager.retrieveLists()
        
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setRightBarButton(btnEdit, animated: false)
    }
    
    @objc func toggleEditMode(sender: Any) {
        let isEditing = self.tableView.isEditing
        self.navigationItem.setRightBarButton(isEditing ? self.btnEdit : self.btnDone, animated: true)
        self.tableView.setEditing(!isEditing, animated: true)
    }
    
    @objc func showEditOptions(_ sender: UITapGestureRecognizer) {
        if let cell = sender.view?.superview as? ListTableViewCell {
            let row = self.tableView.indexPath(for: cell)!.row
            let list = self.lists[row]
            let alert = UIAlertController(title: "Selected list \"\(list.name!)\"", message: "Choose an action", preferredStyle: UIAlertController.Style.actionSheet)
            alert.addAction(UIAlertAction(title: "Rename", style: .default, handler: { _ in self.renameList(list: list) }))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in self.deleteList(list: list) }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: Table View Data Source Methods
    
    func reloadTableView() {
        lists = ListManager.retrieveLists()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        let list = lists[indexPath.row]
        
        cell.lblName.text = list.name
        cell.lblCreationDate.text = dateFormatter.string(from: list.creationDate!)
        if cell.editingAccessoryView!.gestureRecognizers == nil {
            cell.editingAccessoryView!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showEditOptions(_:))))
        }
        
        return cell
    }
    
    // MARK: Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !tableView.isEditing {
            performSegue(withIdentifier: "showListSegue", sender: self.tableView.cellForRow(at:indexPath))
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedList = self.lists[sourceIndexPath.row]
        self.lists.remove(at: sourceIndexPath.row)
        self.lists.insert(movedList, at: destinationIndexPath.row)
        
    }
    
    // MARK: Lists manipulation
    
    @IBAction func addList(_ sender: UIButton) {
        var alert: UIAlertController?
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { action in
            ListManager.newList(name: alert!.textFields![0].text!)
            ListManager.saveContext()
            self.reloadTableView()
        })
        
        alert = UIAlertController(title: "New List", message: "Enter a name for this list", preferredStyle: .alert, successAction: saveAction, txtFieldPlaceholder: "Name")
        self.present(alert!, animated: true, completion: nil)
    }
    
    func renameList(list: List) {
        var alert: UIAlertController?
        
        let renameAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { _ in
            ListManager.editList(list: list, name: alert!.textFields![0].text!)
            ListManager.saveContext()
            self.reloadTableView()
        })
        
        alert = UIAlertController(title: "Rename List", message: "Enter a new name for this list", preferredStyle: .alert, successAction: renameAction, txtFieldPlaceholder: "Name")
        alert!.textFields![0].text = list.name
        self.present(alert!, animated: true, completion: nil)
    }
    
    func deleteList(list: List) {
        ListManager.deleteList(list: list)
        ListManager.saveContext()
        self.reloadTableView()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else { return }
        if let target = segue.destination as? ListViewController {
            target.list = self.lists[selectedIndexPath.row]
        }
    }
}
