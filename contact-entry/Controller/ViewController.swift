//
//  ViewController.swift
//  contact-entry
//
//  Created by Ann Robles on 1/9/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var contactTable: UITableView!
    
    @IBOutlet weak var addButton: UIButton!

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var contacts:[Contact]?
    
    @IBAction func addTapped(_ sender: Any) {
        if let addViewContronller = self.storyboard?.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController {
            self.navigationController?.pushViewController(addViewContronller, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchContact()
    }
    
    func fetchContact() {
        do {
            self.contacts = try context.fetch(Contact.fetchRequest())
            
            DispatchQueue.main.async {
                self.contactTable.reloadData()
            }
        }
        catch {
            
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let contact = self.contacts?[indexPath.row] {
            cell.textLabel?.text = "\(contact.firstName ?? "") \(contact.lastName ?? "")"
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
            
            if let contactToRemove = self.contacts?[indexPath.row] {
                self.context.delete(contactToRemove)
            }

            do {
                try self.context.save()
            } catch  {
                
            }
            
            self.fetchContact()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = self.contacts?[indexPath.row]
        
        if let addViewContronller = self.storyboard?.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController {
            addViewContronller.contact = contact
            self.navigationController?.pushViewController(addViewContronller, animated: true)
        }
    }
}
