//
//  AddViewController.swift
//  contact-entry
//
//  Created by Ann Robles on 1/14/23.
//

import UIKit
import CoreData

class AddViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var contact:Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let oneTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(oneTap)
        
        if contact != nil {
            firstName.text = contact?.firstName
            lastName.text = contact?.lastName
            phoneNumber.text = contact?.phoneNumber
            email.text = contact?.email
        }
    }
    
    @objc func hideKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @IBAction func saveTapped(_ sender: Any) {
        if contact == nil {
            let newContact = Contact(context: self.context)
            newContact.firstName = firstName.text
            newContact.lastName = lastName.text
            newContact.phoneNumber = phoneNumber.text
            newContact.email = email.text
            newContact.fullName = "\(firstName.text ?? "") \(lastName.text ?? "")"
        }
        else {
            contact?.firstName = firstName.text
            contact?.lastName = lastName.text
            contact?.fullName = "\(firstName.text ?? "") \(lastName.text ?? "")"
            contact?.phoneNumber = phoneNumber.text
            contact?.email = email.text
        }
        
        do {
            try self.context.save()
            
            if self.storyboard?.instantiateViewController(withIdentifier: "ViewController") is ViewController {
                self.navigationController?.popViewController(animated: true)
            }
        }
        catch {
            
        }
    }
}
