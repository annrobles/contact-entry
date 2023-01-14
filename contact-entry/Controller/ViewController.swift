//
//  ViewController.swift
//  contact-entry
//
//  Created by Ann Robles on 1/9/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var contactTable: UITableView!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addTapped(_ sender: Any) {
        if let addViewContronller = self.storyboard?.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController {
            self.navigationController?.pushViewController(addViewContronller, animated: true)
        }
    }
}

