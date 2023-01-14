//
//  Contact.swift
//  contact-entry
//
//  Created by Ann Robles on 1/14/23.
//

import Foundation

struct Contact {
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var email: String
    
    init(firstName: String, lastName: String, phoneNumber: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.email = email
    }
}
