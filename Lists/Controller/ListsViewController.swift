//
//  ListsViewController.swift
//  Lists
//
//  Created by Mateus Reckziegel on 02/05/21.
//

import UIKit
import CoreData

class ListsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var persistentContainer: PersistentContainer!
    private var newListAlert: UIAlertController!
    private var lists: Array<List> = []
    private var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard self.persistentContainer != nil else {
            fatalError("Persistent Container needs to be loaded")
        }
        
        dateFormatter.dateFormat = "dd/MM/YY"
        lists = ListManager.retrieveLists()
    }
    
    func reloadTableView() {
        lists = ListManager.retrieveLists()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        let list = lists[indexPath.row]
        cell.textLabel?.text = list.name
        cell.detailTextLabel?.text = dateFormatter.string(from: list.creationDate!)
        
        return cell
    }
    
    @IBAction func addList(_ sender: UIButton) {
        newListAlert = UIAlertController(title: "New List", message: "Enter a name for this list", preferredStyle: UIAlertController.Style.alert)
        newListAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { _ in
            ListManager.newList(name: self.newListAlert.textFields![0].text!)
            self.reloadTableView()
        })
        saveAction.isEnabled = false
        newListAlert.addAction(saveAction)
        newListAlert.preferredAction = saveAction
        
        newListAlert.addTextField { txtFieldName in
            txtFieldName.placeholder = "Name"
            txtFieldName.addTarget(self , action: #selector(self.alertTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        }
        
        self.present(newListAlert, animated: true, completion: nil)
    }
    
    @IBAction private func alertTextFieldDidChange (_ sender: UITextField) {
        newListAlert.preferredAction?.isEnabled = !sender.text!.isEmpty
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
